import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/enums.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/services/microServices/navigationService.dart';
import 'package:platform_front/nav_bar/nav_bar_buttons/howToButton.dart';
import 'package:platform_front/nav_bar/nav_bar_buttons/navBarButton.dart';

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
          children: [
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
              buttonType: NavBarButtonType.closeMenu_org,
            ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.home_org);
                NavigationService.navigateTo('/home_org');
              },
              icon: Icons.home,
              label: 'Home',
              buttonType: NavBarButtonType.home_org,
            ),
            NavBarButton(
              onTap: () {
                ref.read(toggleSubMenuProvider.notifier).toggleSubMenu();
              },
              icon: Icons.layers,
              label: 'Assessment',
              buttonType: NavBarButtonType.createAssessment_org,
            ),
            if (ref.watch(toggleSubMenuProvider))
              Column(
                children: [
                  NavBarButton(
                    onTap: () {
                      ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.newAssessment_org);
                      ref.read(emailListProvider.notifier).loadEmailsFromCache();
                      NavigationService.navigateTo('/createAssessment');
                    },
                    icon: null,
                    label: 'New',
                    buttonType: NavBarButtonType.newAssessment_org,
                  ),
                  NavBarButton(
                    onTap: () {
                      ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.currentAssessment_org);
                      NavigationService.navigateTo('/currentAssessment');
                    },
                    icon: null,
                    label: 'Current',
                    buttonType: NavBarButtonType.currentAssessment_org,
                  ),
                ],
              ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.results_org);
                NavigationService.navigateTo('/results_org');
              },
              icon: Icons.assessment,
              label: 'Results',
              buttonType: NavBarButtonType.results_org,
            ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.impact_rg);
                NavigationService.navigateTo('/impact');
              },
              icon: Icons.location_searching,
              label: 'Focus',
              buttonType: NavBarButtonType.impact_rg,
            ),
            NavBarButton(
              onTap: () {},
              icon: Icons.electric_bolt,
              label: 'Action',
              buttonType: NavBarButtonType.theFix_org,
            ),
          ],
        ),
        Column(
          children: [
            HowToButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.howTo_org);
                NavigationService.navigateTo('/howTo');
              },
              icon: Icons.question_mark,
              label: 'How To',
              buttonType: NavBarButtonType.howTo_org,
            ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.companyInfo_org);
                NavigationService.navigateTo('/companyInfo');
              },
              icon: Icons.person,
              label: 'Company Info',
              buttonType: NavBarButtonType.companyInfo_org,
            ),
            NavBarButton(
              onTap: () {
                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.export_org);
                NavigationService.navigateTo('/export');
              },
              icon: Icons.print,
              label: 'Export',
              buttonType: NavBarButtonType.export_org,
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
              buttonType: NavBarButtonType.logOut_org,
            ),
          ],
        )
      ],
    );
  }
}
