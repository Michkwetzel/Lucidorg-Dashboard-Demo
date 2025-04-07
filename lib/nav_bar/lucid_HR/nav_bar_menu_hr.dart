import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/enums.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/services/microServices/navigationService.dart';
import 'package:platform_front/nav_bar/nav_bar_buttons/navBarButton.dart';

class NavBarMenuHR extends ConsumerWidget {
  const NavBarMenuHR({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
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
            ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.home_hr);
            NavigationService.navigateTo('/home_hr');
          },
          icon: Icons.home,
          label: 'Home',
          buttonType: NavBarButtonType.home_hr,
        ),
        NavBarButton(
          onTap: () {
            ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.results_hr);
            NavigationService.navigateTo('/results_hr');
          },
          icon: Icons.paragliding_rounded,
          label: 'Results',
          buttonType: NavBarButtonType.results_hr,
        ),
      ],
    );
  }
}
