import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/auth/buttons/bottomButtonsRow.dart';
import 'package:platform_front/components/auth/buttons/tempComponents.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/components/global/textfieldGray.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/auth/emailPasswordValidateNotifier.dart';
import 'package:platform_front/components/auth/layouts/appEntryLayout.dart';
import 'package:platform_front/components/auth/layouts/enterTokenLayout.dart';
import 'package:platform_front/components/auth/layouts/userTypeSelectionLayout.dart';
import 'package:platform_front/services/microServices/navigationService.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class EnterEmailPasswordLayout extends ConsumerStatefulWidget {
  final bool logIn; // To keep track if this is a log in screen or a create account screen

  const EnterEmailPasswordLayout({super.key, this.logIn = false});

  @override
  EnterEmailPasswordLayoutState createState() => EnterEmailPasswordLayoutState();
}

class EnterEmailPasswordLayoutState extends ConsumerState<EnterEmailPasswordLayout> {
  final Logger logger = Logger("EnterEmailPasswordLayout");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void>? _pendingNextButtonRequest;
  // ignore: unused_field
  Future<void>? _pendingGoogleSignRequest;

  void succesfullyCreatedAccount() async {
    SnackBarService.showMessage("Successfully created Account", Colors.green);
    await ref.read(userDataProvider.notifier).getUserInfo(ref.read(authfirestoreserviceProvider));
    ref.read(metricsDataProvider.notifier).getSurveyData();

    NavigationService.navigateTo('/home');
    ref.read(authDisplayProvider.notifier).changeDisplay(const AppEntryLayout());
  }

  void successfullyLogIn() async {
    SnackBarService.showMessage("Successfully Logged in", Colors.green);
    await ref.read(userDataProvider.notifier).getUserInfo(ref.read(authfirestoreserviceProvider));
    ref.read(metricsDataProvider.notifier).getSurveyData();
    ref.read(companyInfoService.notifier).getCompanyInfo();
    NavigationService.navigateTo('/home');
    ref.read(authDisplayProvider.notifier).changeDisplay(const AppEntryLayout());
  }

  @override
  Widget build(BuildContext context) {
    EmailPasswordValidationState validationState = ref.watch(emailpasswordvalidateProvider);
    EmailpasswordvalidateNotifer validationNotifier = ref.read(emailpasswordvalidateProvider.notifier);
    var selectedButton = ref.read(selectionButtonProvider);

    void onPressedBackButton() {
      if (selectedButton == SelectionButtonType.exec && !widget.logIn) {
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
            //TODO: Employee gets sent to back but back doesnt do anything different yet.
            //TODO: Implement Log in logic for employees. They create an account with an email on our system.

            if (!widget.logIn) {
              // Create Account

              if (selectedButton == SelectionButtonType.employee) {}

              //If guest or using token

              print('1.attempting to create account');
              await ref.read(authfirestoreserviceProvider.notifier).createUserWithEmailAndPassword(emailController.text, passwordController.text);
              print('2.attempting to create account');

              await ref.read(googlefunctionserviceProvider.notifier).createUserProfile(
                    email: emailController.text,
                    userUID: FirebaseAuth.instance.currentUser!.uid,
                    employee: selectedButton == SelectionButtonType.employee ? true : false,
                    guest: selectedButton == SelectionButtonType.guest ? true : false,
                    authToken: selectedButton == SelectionButtonType.exec ? ref.read(authTokenProvider) : null,
                  );
              print('3.attempting to create account');

              succesfullyCreatedAccount();
            } else {
              // Log in
              // ignore: unused_local_variable
              UserCredential userCred = await ref.read(authfirestoreserviceProvider.notifier).signInWithEmailAndPassword(emailController.text, passwordController.text);
              successfullyLogIn();
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
                validationNotifier.setEmailError(" ");

                validationNotifier.setPasswordError("Invalid credential");
                break;
              default:
                logger.info('Unexpected info $e');
                break;
            }
          } on Exception catch (e) {
            ref.read(authfirestoreserviceProvider.notifier).deleteAccount();
            logger.info('Error logging in or sign up $e');
            SnackBarService.showMessage("Internal Error. Please try again later or Leave message in feedback Button", Colors.red, duration: 10);
          }
        });

        setState(() {
          _pendingNextButtonRequest = pendingNextButtonAuthRequest;
        });
      }
    }

    Future<void> _handleNewUserOnLoginPage(UserCredential? userCred) async {
      await ref.read(authfirestoreserviceProvider.notifier).deleteAccount();
      SnackBarService.showMessage("New Account. Please go to Create Account", Colors.red, duration: 4);
      ref.read(authDisplayProvider.notifier).changeDisplay(AppEntryLayout());
    }

    Future<void> _handleProfileCreationFailure() async {
      // Ensure account deletion happens before showing error message
      try {
        await ref.read(authfirestoreserviceProvider.notifier).deleteAccount();
      } finally {
        SnackBarService.showMessage("Error creating account, Please try again later or click feedback button", Colors.red, duration: 4);
      }
    }

    Future<void> _handleNewUserProfileCreation(UserCredential? userCred) async {
      SnackBarService.showMessage("Creating Account", Colors.blue, duration: 2);

      try {
        final responseBody = await ref.read(googlefunctionserviceProvider.notifier).createUserProfile(
              email: userCred?.user?.email,
              userUID: FirebaseAuth.instance.currentUser!.uid,
              employee: selectedButton == SelectionButtonType.employee,
              guest: selectedButton == SelectionButtonType.guest,
              authToken: selectedButton == SelectionButtonType.exec ? ref.read(authTokenProvider) : null,
            );

        if (responseBody['success']) {
          succesfullyCreatedAccount();
        } else {
          await _handleProfileCreationFailure();
        }
      } on Exception catch (e) {
        await _handleProfileCreationFailure();
      }
    }

    Future<void> _handleGoogleSignIn() async {
      try {
        final userCred = await ref.read(authfirestoreserviceProvider.notifier).signinWithGoogle();

        if (userCred?.additionalUserInfo?.isNewUser != true) {
          return successfullyLogIn();
        }

        if (widget.logIn) {
          await _handleNewUserOnLoginPage(userCred);
        } else {
          await _handleNewUserProfileCreation(userCred);
        }
      } on Exception catch (e) {
        SnackBarService.showMessage("Google sign in error, Please try again later or click feedback button", Colors.red, duration: 3);
      }
    }

    Future<void> googleSignInClicked() async {
      setState(() {
        _pendingGoogleSignRequest = _handleGoogleSignIn();
      });
    }

    return OverlayWidget(
      loadingProvider: ref.watch(authloadStateProvider),
      showChild: true,
      child: Center(
        child: FutureBuilder(
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
            }),
      ),
    );
  }
}
