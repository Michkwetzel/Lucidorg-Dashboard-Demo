import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/auth/layouts/logInScreen.dart';
import 'package:platform_front/core_config/enums.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/global_components/buttons/primaryButton.dart';
import 'package:platform_front/global_components/buttons/secondaryButton.dart';
import 'package:platform_front/global_components/loading_overlay.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/auth/layouts/userTypeSelectionLayout.dart';
import 'package:platform_front/services/microServices/navigationService.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class AppEntryLayout extends ConsumerStatefulWidget {
  const AppEntryLayout({super.key});

  @override
  ConsumerState<AppEntryLayout> createState() => _AppEntryLayoutState();
}

class _AppEntryLayoutState extends ConsumerState<AppEntryLayout> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return OverlayWidget(
      loadingProvider: loading,
      showChild: false,
      child: Center(
        child: Container(
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
              const SizedBox(height: 30),
              CallToActionButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await ref.read(authfirestoreserviceProvider.notifier).signInWithEmailAndPassword("bristol@gmail.com", "123456");
                  await ref.read(userDataProvider.notifier).getUserInfo(ref.read(authfirestoreserviceProvider));
                  if (ref.read(userDataProvider).latestSurveyDocName != null) {
                    ref.read(currentEmailListProvider.notifier).getCurrentEmails();
                  }
                  await ref.read(metricsDataProvider.notifier).getSurveyData();
                  ref.read(companyInfoService.notifier).getCompanyInfo();
                  ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.home_org);
                  NavigationService.navigateTo('/home_org');
                  setState(() {
                    loading = false;
                  });
                  ref.read(authDisplayProvider.notifier).changeDisplay(const AppEntryLayout());
                },
                buttonText: "Demo Sign in",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
