import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/enums.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/nav_bar/lucid_HR/nav_bar_menu_hr.dart';
import 'package:platform_front/nav_bar/lucid_ORG/nav_bar_menu_org.dart';
import 'package:platform_front/nav_bar/nav_bar_buttons/switch_product_button.dart';

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
          width: ref.watch(navBarExpandStateNotifier) ? 230 : 67,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24, left: 12, right: 12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ref.watch(navBarExpandStateNotifier)
                            ? Row(
                                spacing: 12,
                                children: [
                                  SizedBox(
                                    height: 35.5,
                                    child: Image.asset(
                                      'assets/logo/logo.jpg',
                                    ),
                                  ),
                                  SwitchProductButton(),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                                child: SizedBox(
                                  width: 35,
                                  height: 35.5,
                                  child: Image.asset(
                                    'assets/logo/logoImage.png',
                                  ),
                                )),
                        Expanded(
                          child: ref.watch(navBarProvider).selectedProduct == Product.org ? NavBarMenuOrg() : NavBarMenuHR(),
                        ),
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
