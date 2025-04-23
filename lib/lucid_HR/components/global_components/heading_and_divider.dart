import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/gray_divider.dart';

class HeadingAndDivider extends StatelessWidget {
  final String heading;
  const HeadingAndDivider({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(heading, style: kH2TextStyle), CustomDivider()],
    );
  }
}
