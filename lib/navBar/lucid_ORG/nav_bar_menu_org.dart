import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/services/microServices/navigationService.dart';
import 'package:platform_front/navBar/nav_bar_buttons/howToButton.dart';
import 'package:platform_front/navBar/nav_bar_buttons/navBarButton.dart';

class NavBarMenuOrg extends ConsumerWidget {
  const NavBarMenuOrg({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: ref.watch(navBarExpandStateNotifier)
                    ? SizedBox(
                        height: 35.5,
                        child: Image.asset(
                          'assets/logo/logo.jpg',
                        ),
                      )
                    : SizedBox(
                        width: 35,
                        height: 35.5,
                        child: Image.asset(
                          'assets/logo/logoImage.png',
                        ),
                      )),
            const SizedBox(height: 4),
            NavBarButton(
              onTap: () {
                if (ref.watch(navBarExpandStateNotifier)) {
                  ref.read(navBarExpandStateNotifier.notifier).shrink();
                } else {
                  ref.read(navBarExpandStateNotifier.notifier).expand();
                }
              },
              icon: ref.watch(navBarExpandStateNotifier) ? Icons.arrow_back_ios : Icons.menu,
              label: '',
              buttonType: NavBarButtonType.closeMenu,
            ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.home);
                NavigationService.navigateTo('/home');
              },
              icon: Icons.home,
              label: 'Home',
              buttonType: NavBarButtonType.home,
            ),
            NavBarButton(
              onTap: () {
                ref.read(toggleSubMenuProvider.notifier).toggleSubMenu();
              },
              icon: Icons.layers,
              label: 'Assessment',
              buttonType: NavBarButtonType.createAssessment,
            ),
            if (ref.watch(toggleSubMenuProvider))
              Column(
                children: [
                  NavBarButton(
                    onTap: () {
                      ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.currentAssessment);
                      NavigationService.navigateTo('/currentAssessment');
                    },
                    icon: null,
                    label: 'Current',
                    buttonType: NavBarButtonType.currentAssessment,
                  ),
                  NavBarButton(
                    onTap: () {
                      ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.newAssessment);
                      ref.read(emailListProvider.notifier).loadEmailsFromCache();
                      NavigationService.navigateTo('/createAssessment');
                    },
                    icon: null,
                    label: 'New',
                    buttonType: NavBarButtonType.newAssessment,
                  ),
                ],
              ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.results);
                NavigationService.navigateTo('/results');
              },
              icon: Icons.assessment,
              label: 'Results',
              buttonType: NavBarButtonType.results,
            ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.impact);
                NavigationService.navigateTo('/impact');
              },
              icon: Icons.electric_bolt,
              label: 'Impact',
              buttonType: NavBarButtonType.impact,
            ),
          ],
        ),
        Column(
          children: [
            HowToButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.howTo);
                NavigationService.navigateTo('/howTo');
              },
              icon: Icons.question_mark,
              label: 'How To',
              buttonType: NavBarButtonType.howTo,
            ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.companyInfo);
                NavigationService.navigateTo('/companyInfo');
              },
              icon: Icons.person,
              label: 'Company Info',
              buttonType: NavBarButtonType.companyInfo,
            ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.results);
                NavigationService.navigateTo('/export');
              },
              icon: Icons.assessment,
              label: 'Export',
              buttonType: NavBarButtonType.results,
            ),
            NavBarButton(
              onTap: () {
                ref.read(authfirestoreserviceProvider.notifier).signOutUser();
                ref.read(metricsDataProvider.notifier).resetToInitialState();
                ref.read(currentEmailListProvider.notifier).clearEmails();
                NavigationService.navigateTo('/auth');
              },
              icon: Icons.logout,
              label: 'Log out',
              buttonType: NavBarButtonType.logOut,
            ),
          ],
        )
      ],
    );
  }
}
