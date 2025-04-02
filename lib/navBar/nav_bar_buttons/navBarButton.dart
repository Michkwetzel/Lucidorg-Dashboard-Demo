import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/navBar/navigationBar.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class NavBarButton extends ConsumerWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  final NavBarButtonType buttonType;

  const NavBarButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.buttonType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding:  icon == null ? const EdgeInsets.only(top: 12) : const EdgeInsets.only(top: 16),
      child: MaterialButton(
        padding: icon == null ? EdgeInsets.symmetric(vertical: 8, horizontal: 16) : const EdgeInsets.symmetric(vertical:  12, horizontal:  16),
        onPressed: ref.watch(googlefunctionserviceProvider).loading ? null : onTap,
        //TODO:Check here
        color: ref.watch(navBarProvider) == buttonType ? const Color(0xFFE8ECEC) : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (buttonType == NavBarButtonType.closeMenu && ref.watch(navBarExpandStateNotifier))
              SizedBox(
                width: 4,
              ),
            icon == null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.8, right: 8),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFA1B084),
                      radius: 5,
                    ),
                  )
                : Icon(
                    icon,
                    size: 26.5,
                  ),
            if (ref.watch(navBarExpandStateNotifier))
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    label,
                    style: icon == null ? TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black) : kSidePanelButtonsTextStyle,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
