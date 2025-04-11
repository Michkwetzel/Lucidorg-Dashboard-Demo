// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double? width;
  final Color color;
  final double? thickness;
  

  const CustomDivider({
    this.thickness = 1,
    this.width,
    this.color = const Color(0xFFC7C7C7),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (width == null) {
      return Divider(color: color, thickness: thickness);
    } else {
      return SizedBox(width: width, child: Divider(color: color, thickness: thickness));
    }
  }
}
