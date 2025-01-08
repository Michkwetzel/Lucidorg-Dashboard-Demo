import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/navBar/navBarButton.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/services/microServices/navigationService.dart';

class NavBar extends ConsumerWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 60, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        width: 280,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24, left: 12, right: 12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Image.asset(
                              'assets/logo/tempLogo.png',
                              scale: 4,
                            ),
                          ),
                          const SizedBox(height: 24),
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
                              ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.createAssessment);
                              NavigationService.navigateTo('/createAssessment');
                            },
                            icon: Icons.layers_outlined,
                            label: 'Assessment',
                            buttonType: NavBarButtonType.createAssessment,
                          ),
                          NavBarButton(
                            onTap: () {
                              ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.results);
                            },
                            icon: Icons.format_align_center,
                            label: 'Results',
                            buttonType: NavBarButtonType.results,
                          ),
                          NavBarButton(
                            onTap: () => {},
                            icon: Icons.highlight_alt_rounded,
                            label: 'Blueprints',
                            buttonType: NavBarButtonType.blueprints,
                          ),
                        ],
                      ),
                      Column(
                        children: [
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
                            onTap: () => ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.logOut),
                            icon: Icons.logout_outlined,
                            label: 'Log out',
                            buttonType: NavBarButtonType.logOut,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
