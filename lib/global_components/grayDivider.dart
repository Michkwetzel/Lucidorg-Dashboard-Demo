// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GrayDivider extends StatelessWidget {
  final double? width;
  const GrayDivider({
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (width == null) {
      return Divider(color: Color(0xFFC7C7C7), thickness: 1);
    } else {
      return SizedBox(width: width, child: Divider(color: Color(0xFFC7C7C7), thickness: 1));
    }
  }
}