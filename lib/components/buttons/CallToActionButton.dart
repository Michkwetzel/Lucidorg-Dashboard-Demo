import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class CallToActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool isSuccess;

  const CallToActionButton({super.key, required this.onPressed, required this.buttonText, this.isSuccess = false,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kButtonHeight,
      child: MaterialButton(

        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        onPressed: onPressed,
        color: const Color(0xFFA2B185),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        child: Text(
          buttonText,
          style: kCallToActionButtonTextStyle,
        ),
      ),
    );
  }
}
