import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';

class Custombackbutton extends StatelessWidget {
  final VoidCallback onPressed;

  const Custombackbutton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      height: kButtonHeight,
      child: MaterialButton(
          onPressed: onPressed,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFBBBBBB), width: 1),
          ),
          elevation: 1,
          child: const Icon(
            Icons.chevron_left,
            color: Color(0xFF69ABFF),
            size: 25,
          )),
    );
  }
}
