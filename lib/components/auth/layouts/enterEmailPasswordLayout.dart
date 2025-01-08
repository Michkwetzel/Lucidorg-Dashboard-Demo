import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/auth/buttons/bottomButtonsRow.dart';
import 'package:platform_front/components/auth/buttons/tempComponents.dart';
import 'package:platform_front/components/textFields/textfieldGray.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/auth/emailPasswordValidateNotifier.dart';
import 'package:platform_front/components/auth/layouts/appEntryLayout.dart';
import 'package:platform_front/components/auth/layouts/enterTokenLayout.dart';
import 'package:platform_front/components/auth/layouts/userTypeSelectionLayout.dart';

class EnterEmailPasswordLayout extends ConsumerStatefulWidget {
  final bool logIn;

  const EnterEmailPasswordLayout({super.key, this.logIn = false});

  @override
  _EnterEmailPasswordLayoutState createState() => _EnterEmailPasswordLayoutState();
}

class _EnterEmailPasswordLayoutState extends ConsumerState<EnterEmailPasswordLayout> {
  final Logger logger = Logger("EnterEmailPasswordLayout");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void>? _pendingNextButtonRequest;
  // ignore: unused_field
  Future<void>? _pendingGoogleSignRequest;

  void _showStandardBottomSheet(BuildContext context, String displayMessage) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 2), () {
          try {
            if (Navigator.of(context).mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          } catch (e) {
            logger.info('Bottom Sheet closed before timere: $e');
          }
        });
        return Container(
          decoration: const BoxDecoration(color: Color(0xFFBDF1F7), shape: BoxShape.rectangle, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          height: 100,
          width: 350,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              displayMessage,
              style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Open Sans"),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    EmailPasswordValidationState validationState = ref.watch(emailpasswordvalidateProvider);
    EmailpasswordvalidateNotifer validationNotifier = ref.read(emailpasswordvalidateProvider.notifier);
    var selectedButton = ref.read(selectionButtonProvider);

    void onPressedBackButton() {
      if (selectedButton == SelectionButtonType.token && !widget.logIn) {
        ref.read(authDisplayProvider.notifier).changeDisplay(const EnterTokenLayout());
      } else if (widget.logIn) {
        ref.read(authDisplayProvider.notifier).changeDisplay(const AppEntryLayout());
      } else {
        ref.read(authDisplayProvider.notifier).changeDisplay(const UserTypeSelectionLayout());
      }
      validationNotifier.setEmailError('');
      validationNotifier.setPasswordError('');
    }

    void onPressedNextButton() async {
      validationNotifier.validateEmail(emailController.text);
      validationNotifier.validatePassword(passwordController.text);

      if (validationNotifier.isValid) {
        Future<void> pendingNextButtonAuthRequest = Future(() async {
          try {
            //TODO: for now employee is also guest. Later change to logic for employee signing in aswell.

            if (!widget.logIn) {
              await ref.read(authfirestoreserviceProvider.notifier).createUserWithEmailAndPassword(emailController.text, passwordController.text);
              final responseBody = await ref.read(googlefunctionserviceProvider.notifier).createUserProfile(
                    email: emailController.text,
                    userUID: FirebaseAuth.instance.currentUser!.uid,
                    guest: selectedButton == SelectionButtonType.guest ? true : false,
                    authToken: selectedButton == SelectionButtonType.token ? ref.read(authTokenProvider) : null,
                  );

              if (responseBody['success']) {
                _showStandardBottomSheet(context, "Account created successfully");
                await Future.delayed(const Duration(seconds: 2));
                //TODO: Go to next screen
              } else {
                //TODO: display message, not succesffull.
              }
            } else {
              // ignore: unused_local_variable
              UserCredential userCred = await ref.read(authfirestoreserviceProvider.notifier).signInWithEmailAndPassword(emailController.text, passwordController.text);
              _showStandardBottomSheet(context, "Logged in");
              await Future.delayed(const Duration(seconds: 2));
            }
          } on FirebaseAuthException catch (e) {
            logger.info('Error logging in or sign up with Firebase Auth Account: ${e.code}');
            switch (e.code) {
              case 'email-already-in-use':
                validationNotifier.setEmailError("Email Already in use");
                break;
              case 'invalid-email':
                validationNotifier.setEmailError("Invalid email");
                break;
              case 'weak-password':
                validationNotifier.setEmailError("Password must be at least 6 characters");
                break;
              case 'network-request-failed':
                validationNotifier.setEmailError("Network Error");
                break;
              case 'user-not-found':
                validationNotifier.setEmailError("User not found");
                break;
              case 'wrong-password':
                validationNotifier.setEmailError("Wrong password");
                break;
              case 'invalid-credential':
                validationNotifier.setEmailError("Invalid credential");
                break;
              default:
                logger.info('Unexpected info $e');
                break;
            }
          } on Exception catch (e) {
            logger.info('Error logging in or sign up $e');
            validationNotifier.setEmailError("Invalid");
          }
        });

        setState(() {
          _pendingNextButtonRequest = pendingNextButtonAuthRequest;
        });
      }
    }

    void googleSignInClicked() async {
      UserCredential? userCred;
      Future<void> pendingGoogleSignRequest = Future(() async {
        try {
          userCred = await ref.read(authfirestoreserviceProvider.notifier).signinWithGoogle();

          if (userCred!.additionalUserInfo!.isNewUser) {
            //If new google account. Also create profile
            _showStandardBottomSheet(context, "Creating Account");
            final responseBody = await ref.read(googlefunctionserviceProvider.notifier).createUserProfile(
                  // This logic here actualy takes care of which user it is. Except Employee
                  email: userCred?.user?.email,
                  userUID: FirebaseAuth.instance.currentUser!.uid,
                  guest: selectedButton == SelectionButtonType.guest ? true : false,
                  authToken: selectedButton == SelectionButtonType.token ? ref.read(authTokenProvider) : null,
                );

            if (responseBody['success']) {
              _showStandardBottomSheet(context, "Account created successfully");
              await Future.delayed(const Duration(seconds: 2));
            }
          } else {
            //TODO: Log in Logic
          }
        } on Exception {
          _showStandardBottomSheet(context, "Google Sign in Error");
          await Future.delayed(const Duration(seconds: 2));
        }
      });
      setState(() {
        _pendingGoogleSignRequest = pendingGoogleSignRequest;
      });
    }

    return FutureBuilder(
        future: _pendingNextButtonRequest,
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.all(32),
            width: 350,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo/tempLogo.png', scale: kLogoScale),
                const SizedBox(height: 12),
                const Text("Email", style: kTextFieldHeaderTextStyle),
                const SizedBox(height: 2),
                TextfieldGray(
                  height: 50,
                  controller: emailController,
                  isLoading: snapshot.connectionState == ConnectionState.waiting,
                  error: validationState.emailError != null,
                  errorText: validationState.emailError ?? '',
                ),
                validationState.emailError != null ? const SizedBox(height: 4) : const SizedBox(height: 12),
                const Text("Password", style: kTextFieldHeaderTextStyle),
                const SizedBox(height: 2),
                TextfieldGray(
                  height: 50,
                  controller: passwordController,
                  isLoading: snapshot.connectionState == ConnectionState.waiting,
                  error: validationState.passwordError != null,
                  errorText: validationState.passwordError ?? '',
                ),
                validationState.emailError != null ? const SizedBox(height: 8) : const SizedBox(height: 12),
                const SizedBox(height: 4),
                const LineBreak(
                  colour: 'black',
                ),
                const SizedBox(height: 4),
                GoogleSignInButton(onPressed: () => googleSignInClicked()),
                const SizedBox(
                  height: 18,
                ),
                BottomButtonsRow(
                  onPressedBackButton: () => onPressedBackButton(),
                  onPressedNextButton: () {
                    snapshot.connectionState != ConnectionState.waiting || snapshot.connectionState == ConnectionState.none ? onPressedNextButton() : null;
                  },
                  nextButtonText: widget.logIn ? "Log in" : "Continue",
                ),
              ],
            ),
          );
        });
  }
}
