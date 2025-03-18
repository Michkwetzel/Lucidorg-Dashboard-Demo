import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/navBar/navigationBar.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class NavBarSubButton extends ConsumerWidget {
  final String label;
  final VoidCallback onTap;
  final NavBarButtonType buttonType;

  const NavBarSubButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.buttonType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.8, right: 8),
          child: CircleAvatar(
            foregroundColor: Colors.green,
            backgroundColor: Colors.green,
            radius: 5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: MaterialButton(
            padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
            onPressed: onTap,
            color: ref.watch(navBarProvider) == buttonType ? const Color(0xFFE8ECEC) : Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (ref.watch(navBarExpandStateNotifier))
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        label,
                        style: TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
