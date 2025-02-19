import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/navBar/navBarButton.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/services/microServices/navigationService.dart';

class NavBar extends ConsumerStatefulWidget {
  const NavBar({
    super.key,
  });

  @override
  ConsumerState<NavBar> createState() => _NavBarState();
}

class _NavBarState extends ConsumerState<NavBar> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handleResize();
  }

  void _handleResize() {
    double width = MediaQuery.of(context).size.width;
    if (width < 1500 && ref.read(navBarExpandStateNotifier)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(navBarExpandStateNotifier.notifier).shrink();
      });
    } else if (width >= 1500 && !ref.read(navBarExpandStateNotifier)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(navBarExpandStateNotifier.notifier).expand();
      });
    }
  }

  BoxDecoration decoration = BoxDecoration();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 32, bottom: 16),
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            decoration = BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            );
          });
        },
        onExit: (event) {
          setState(() {
            decoration = BoxDecoration();
          });
        },
        child: Container(
          decoration: decoration,
          width: ref.watch(navBarExpandStateNotifier) ? 200 : 67,
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
                                ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.createAssessment);
                                NavigationService.navigateTo('/createAssessment');
                              },
                              icon: Icons.layers,
                              label: 'Assessment',
                              buttonType: NavBarButtonType.createAssessment,
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
                            NavBarButton(
                              onTap: () => {},
                              icon: Icons.build,
                              label: 'The Fix',
                              buttonType: NavBarButtonType.theFix,
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
                              onTap: () {
                                ref.read(authfirestoreserviceProvider.notifier).signOutUser();
                                NavigationService.navigateTo('/auth');
                              },
                              icon: Icons.logout,
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
      ),
    );
  }
}
