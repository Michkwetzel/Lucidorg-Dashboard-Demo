import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/authScreen/bottomButtonsRow.dart';
import 'package:platform_front/components/textFields/textfieldGray.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/auth/emailPasswordValidateNotifier.dart';
import 'package:platform_front/screenLayouts/authScreen/enterTokenLayout.dart';
import 'package:platform_front/screenLayouts/authScreen/userTypeSelectionLayout.dart';

class EnterEmailPasswordLayout extends ConsumerWidget {
  final Logger logger = Logger("EnterEmailPasswordLayout");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final bool logIn;

  EnterEmailPasswordLayout({super.key, this.logIn = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EmailPasswordValidationState validationState = ref.watch(emailpasswordvalidateProvider);
    EmailpasswordvalidateNotifer validationNotifier = ref.read(emailpasswordvalidateProvider.notifier);

    void onPressedBackButton() {
      var selectedButton = ref.read(selectionButtonProvider);
      if (selectedButton == SelectionButtonType.token) {
        ref.read(authDisplayProvider.notifier).changeDisplay(const EnterTokenLayout());
      } else {
        ref.read(authDisplayProvider.notifier).changeDisplay(const UserTypeSelectionLayout());
      }
    }

    void onPressedNextButton() async {
      validationNotifier.validateEmail(emailController.text);
      validationNotifier.validatePassword(passwordController.text);

      if (validationNotifier.isValid) {
        try {
          await ref.read(authfirestoreserviceProvider.notifier).createUserWithEmailAndPassword(emailController.text, passwordController.text);
        } on FirebaseAuthException catch (e) {
          logger.info('Error on creating Firebase Auth Account ${e.code}');
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
            default:
              logger.info('Unexpected info $e');
          }
        } on Exception catch (e) {
          logger.info('Error on creating Firebase Auth Account $e');
        }
      }

      //ref.read(authfirestoreserviceProvider.notifier).setInputEmail(inputEmail);
      //ref.read(authfirestoreserviceProvider.notifier).setInputPassword(inputPassword);
      //ref.read(authfirestoreserviceProvider.notifier).createUserWithEmailAndPassword();
      //ref.read(authDisplayProvider.notifier).changeDisplay(EnterEmailPasswordLayout());
      //ref.read(authfirestoreserviceProvider.notifier).printState();

      //TODO: Create username and password
    }

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
            controller: emailController,
            error: validationState.emailError != null,
            errorText: validationState.emailError ?? '',
          ),
          const SizedBox(height: 24),
          const Text("Password", style: kTextFieldHeaderTextStyle),
          const SizedBox(height: 2),
          TextfieldGray(
            controller: passwordController,
            error: validationState.passwordError != null,
            errorText: validationState.passwordError ?? '',
          ),
          const SizedBox(height: 24),
          BottomButtonsRow(
            onPressedBackButton: () => onPressedBackButton(),
            onPressedNextButton: () => onPressedNextButton(),
            nextButtonText: logIn ? "Log in" : "Continue",
          ),
        ],
      ),
    );
  }
}
