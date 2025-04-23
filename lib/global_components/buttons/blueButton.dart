import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class BlueButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool isSuccess;
  final bool disabled;

  const BlueButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.disabled = false,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: kButtonHeight,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        disabledColor: const Color(0x40A2B185),
        onPressed: disabled ? null : onPressed,
        color: const Color(0xFFBDF1F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: const Color(0xFF0118E5), width: 1),
        ),
        elevation: 1,
        child: Text(
          buttonText,
          style: TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }
}
