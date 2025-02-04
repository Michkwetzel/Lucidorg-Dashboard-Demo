import 'package:flutter/material.dart';
import 'package:platform_front/components/global/score_boxes/diff_box.dart';
import 'package:platform_front/config/constants.dart';

class AreaDiffRow extends StatelessWidget {
  final String heading;
  final double diff;
  const AreaDiffRow({super.key, required this.heading, required this.diff});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            heading,
            style: kH5PoppinsLight,
          ),
        ),
        DiffBox(diff: diff, width: 60, height: 45, textSize: 14, fontWeight: FontWeight.w300)
      ],
    );
  }
}
