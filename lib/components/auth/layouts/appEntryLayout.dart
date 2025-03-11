import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/auth/layouts/createAccountScreen.dart';
import 'package:platform_front/components/auth/layouts/logInScreen.dart';
import 'package:platform_front/components/global/buttons/CallToActionButton.dart';
import 'package:platform_front/components/global/buttons/secondaryButton.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/components/auth/layouts/enterEmailPasswordLayout.dart';
import 'package:platform_front/components/auth/layouts/userTypeSelectionLayout.dart';
import 'package:platform_front/services/microServices/navigationService.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class AppEntryLayout extends ConsumerWidget {
  const AppEntryLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Image.asset(
            'assets/logo/logo.jpg',
            width: 300,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Secondarybutton(
                onPressed: () => ref.read(authDisplayProvider.notifier).changeDisplay(UserTypeSelectionLayout()),
                buttonText: "Create Account",
              ),
              CallToActionButton(
                onPressed: () => ref.read(authDisplayProvider.notifier).changeDisplay(LogInScreen()),
                buttonText: "Log in",
              )
            ],
          ),
          // const SizedBox(
          //   height: 24,
          // ),
          // Secondarybutton(
          //     onPressed: () async {
          //       try {
          //         await ref.read(authfirestoreserviceProvider.notifier).signInWithEmailAndPassword('test@gmail.com', 'qwertyqwerty');
          //         await ref.read(userDataProvider.notifier).getUserInfo(ref.read(authfirestoreserviceProvider));
          //         ref.read(companyInfoService.notifier).getCompanyInfo();
          //         ref.read(metricsDataProvider.notifier).getSurveyData('testCompany');
          //         ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.home);
          //         NavigationService.navigateTo('/home');
          //         SnackBarService.showMessage('Succesfull Test Log in', Colors.green);
          //         //ref.read(metricsDataProvider.notifier).initializeDefault();
          //       } on Exception {
          //         SnackBarService.showMessage('System Error', Colors.red);
          //       }
          //     },
          //     buttonText: "Test"),
        ],
      ),
    );
  }
}
