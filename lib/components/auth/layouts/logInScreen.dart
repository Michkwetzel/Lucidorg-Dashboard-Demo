import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/auth/buttons/bottomButtonsRow.dart';
import 'package:platform_front/components/auth/buttons/tempComponents.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/components/auth/layouts/appEntryLayout.dart';
import 'package:platform_front/services/microServices/navigationService.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  bool loading = false;
  String? errorText;
  final _formKey = GlobalKey<FormState>(); // Add this line

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger("LogIn");

    Future<void> successfullyLogIn() async {
      try {
        SnackBarService.showMessage("Successfully Logged in", Colors.green);
        await ref.read(userDataProvider.notifier).getUserInfo(ref.read(authfirestoreserviceProvider));
        ref.read(metricsDataProvider.notifier).getSurveyData();
        ref.read(companyInfoService.notifier).getCompanyInfo();
        NavigationService.navigateTo('/home');
        ref.read(authDisplayProvider.notifier).changeDisplay(const AppEntryLayout());
      } on Exception catch (e) {
        setState(() {
          loading = false;
        });
        SnackBarService.showMessage("Error signing in. Please try again later", Colors.red, duration: 4);
      }
    }

    void googleSignInClicked() async {
      try {
        setState(() {
          errorText = null;
          loading = true;
        });
        final userCred = await ref.read(authfirestoreserviceProvider.notifier).signinWithGoogle();

        //Log in via Google
        if (userCred?.additionalUserInfo?.isNewUser != true) {
          successfullyLogIn();
        } else {
          // new user. needs to go to create account page
          await ref.read(authfirestoreserviceProvider.notifier).deleteAccount();
          setState(() {
            loading = false;
          });
          SnackBarService.showMessage("New email address. Please create an account", Colors.red, duration: 4);
          ref.read(authDisplayProvider.notifier).changeDisplay(AppEntryLayout());
        }
      } on Exception catch (e) {
        setState(() {
          loading = false;
        });
        logger.severe(e);
        SnackBarService.showMessage("Google sign in error, Please try again later or click feedback button", Colors.red, duration: 4);
      }
    }

    void emailPasswordSignIn() async {
      setState(() {
        errorText = null;
      });
      if (_formKey.currentState!.validate()) {
        // Add validation check
        try {
          setState(() {
            loading = true;
          });
          await ref.read(authfirestoreserviceProvider.notifier).signInWithEmailAndPassword(ref.read(emailPasswordProvider.notifier).getEmail(), ref.read(emailPasswordProvider.notifier).getPassword());
          await successfullyLogIn();
        } on FirebaseAuthException catch (e) {
          logger.info('Error logging in with Firebase Auth Account: ${e.code}');
          String forcedErrorText = '';
          switch (e.code) {
            case 'network-request-failed':
              forcedErrorText = "Network Error";
            case 'user-not-found':
              forcedErrorText = "User not found";
            case 'wrong-password':
              forcedErrorText = "Wrong password";
            case 'invalid-credential':
              forcedErrorText = "Invalid Credentials";
            default:
              forcedErrorText = "Error";
          }
          setState(() {
            errorText = forcedErrorText;
            loading = false;
          });
        }
      }
    }

    return OverlayWidget(
      loadingProvider: loading,
      showChild: true,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          width: 350,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo/logo.jpg', scale: kLogoScale),
                const SizedBox(height: 12),
                const Text("Email", style: kTextFieldHeaderTextStyle),
                const SizedBox(height: 2),
                FormTextField(
                  forcedErrorText: errorText,
                  textFieldType: "email",
                  validator: (value) {
                    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                    if (value == null) {
                      return 'Email cannot be empty';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
                Text("Password", style: kTextFieldHeaderTextStyle),
                SizedBox(height: 2),
                FormTextField(
                  textFieldType: "password",
                  validator: (value) {
                    if (value == null) {
                      return 'Password cannot be empty';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                LineBreak(
                  colour: 'black',
                ),
                GoogleSignInButton(onPressed: () => googleSignInClicked()),
                SizedBox(
                  height: 18,
                ),
                BottomButtonsRow(
                  onPressedBackButton: () {
                    ref.read(authDisplayProvider.notifier).changeDisplay(const AppEntryLayout());
                  },
                  onPressedNextButton: () => emailPasswordSignIn(),
                  nextButtonText: "Log in",
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}

class FormTextField extends ConsumerWidget {
  final String? Function(String?)? validator;
  final String textFieldType;
  final String? forcedErrorText;

  const FormTextField({super.key, required this.validator, required this.textFieldType, this.forcedErrorText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
        forceErrorText: forcedErrorText,
        validator: validator,
        enableInteractiveSelection: true,
        onChanged: (value) {
          if (textFieldType == 'email') {
            ref.read(emailPasswordProvider.notifier).updateEmail(value);
          } else {
            ref.read(emailPasswordProvider.notifier).updatePassword(value);
          }
        },
        maxLines: null,
        style: const TextStyle(
          letterSpacing: 0.4,
          fontSize: 16.0,
          height: 1.5,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: const Color(0xFFF3F3F3),
          contentPadding: const EdgeInsets.all(6),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
        ));
  }
}
