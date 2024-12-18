import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class NavBarButton extends ConsumerWidget {
  final IconData icon;
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
      padding: const EdgeInsets.only(top: 16),
      child: MaterialButton(
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
        onPressed: onTap,
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
            Icon(
              icon,
              size: 26.5,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: kSidePanelButtonsTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
