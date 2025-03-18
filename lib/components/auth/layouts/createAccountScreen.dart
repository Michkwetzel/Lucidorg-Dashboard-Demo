import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/auth/buttons/bottomButtonsRow.dart';
import 'package:platform_front/components/auth/buttons/tempComponents.dart';
import 'package:platform_front/components/auth/layouts/enterTokenLayout.dart';
import 'package:platform_front/components/auth/layouts/userTypeSelectionLayout.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/components/auth/layouts/appEntryLayout.dart';
import 'package:platform_front/services/microServices/navigationService.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() => _CreateAccountScreen();
}

class _CreateAccountScreen extends ConsumerState<CreateAccountScreen> {
  bool loading = false;
  String? errorText;
  final _formKey = GlobalKey<FormState>(); // Add this line

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger("CreateAccount");
    var selectedButton = ref.read(selectionButtonProvider);

    Future<void> getDataAndOpenDashboard() async {
      try {
        SnackBarService.showMessage("Successfully Created Account", Colors.green);
        await ref.read(userDataProvider.notifier).getUserInfo(ref.read(authfirestoreserviceProvider));
        if (ref.read(userDataProvider).latestSurveyDocName != null) {
          ref.read(currentEmailListProvider.notifier).getCurrentEmails();
        }

        await ref.read(metricsDataProvider.notifier).getSurveyData();
        ref.read(financeModelProvider.notifier).calculateInitialValues();
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
          getDataAndOpenDashboard();
        } else {
          await ref.read(googlefunctionserviceProvider.notifier).createUserProfile(
                email: userCred?.user?.email,
                userUID: FirebaseAuth.instance.currentUser!.uid,
                employee: selectedButton == SelectionButtonType.employee,
                guest: selectedButton == SelectionButtonType.guest,
                exec: selectedButton == SelectionButtonType.exec,
                authToken: selectedButton == SelectionButtonType.exec ? ref.read(authTokenProvider) : null,
              );
        }
        getDataAndOpenDashboard();
        setState(() {
          loading = false;
        });
      } on Exception catch (e) {
        setState(() {
          loading = false;
        });
        logger.severe(e);
        SnackBarService.showMessage("Google sign in error, Please try again later or click feedback button", Colors.red, duration: 4);
      }
    }

    void emailPasswordCreateAccount() async {
      setState(() {
        errorText = null;
      });
      if (_formKey.currentState!.validate()) {
        // Add validation check
        try {
          setState(() {
            loading = true;
          });

          print('1.attempting to create account');
          await ref
              .read(authfirestoreserviceProvider.notifier)
              .createUserWithEmailAndPassword(ref.read(emailPasswordProvider.notifier).getEmail(), ref.read(emailPasswordProvider.notifier).getPassword());
          print('2.attempting to create account');

          await ref.read(googlefunctionserviceProvider.notifier).createUserProfile(
                email: ref.read(emailPasswordProvider.notifier).getEmail(),
                userUID: FirebaseAuth.instance.currentUser!.uid,
                employee: selectedButton == SelectionButtonType.employee ? true : false,
                guest: selectedButton == SelectionButtonType.guest ? true : false,
                exec: selectedButton == SelectionButtonType.exec,
                authToken: selectedButton == SelectionButtonType.exec ? ref.read(authTokenProvider) : null,
              );

          print('3.attempting to create account');

          getDataAndOpenDashboard();
        } on FirebaseAuthException catch (e) {
          logger.info('Error Creating Firebase account: ${e.code}');
          String forcedErrorText = '';
          switch (e.code) {
            case 'email-already-in-use':
              forcedErrorText = "Email Already in use";
            case 'invalid-email':
              forcedErrorText = "Invalid email";
            case 'weak-password':
              forcedErrorText = "Password must be at least 6 characters";
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
        } on Exception catch (e) {
          ref.read(authfirestoreserviceProvider.notifier).deleteAccount();
          logger.warning('Error logging in or sign up $e');
          SnackBarService.showMessage("Internal Error. Please try again later or Leave message in feedback Button", Colors.red, duration: 6);
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
                    if (selectedButton == SelectionButtonType.exec) {
                      ref.read(authDisplayProvider.notifier).changeDisplay(const EnterTokenLayout());
                    } else {
                      ref.read(authDisplayProvider.notifier).changeDisplay(const UserTypeSelectionLayout());
                    }
                  },
                  onPressedNextButton: () => emailPasswordCreateAccount(),
                  nextButtonText: "Create Account",
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
