import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/global_org/diffTriangleRedWidget.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class FocusAreaRow extends StatelessWidget {
  final String text;
  final double diff;
  final double score;
  final FocusSection section;

  const FocusAreaRow({required this.text, required this.diff, required this.score, required this.section, super.key});

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = kGrayBox;

    switch (section) {
      case FocusSection.diffPyramid:
        if (diff > 20) {
          decoration = kRedBox;
        } else if (diff > 10) {
          decoration = kYellowBox;
        } else if (diff > 5) {
          decoration = kGreenBox;
        }
        break;
      case FocusSection.scorePyramid:
        if (score < 40) {
          decoration = kRedBox;
        } else if (score < 50) {
          decoration = kYellowBox;
        } else if (score < 60) {
          decoration = kGrayBox;
        } else {
          decoration = kGreenBox;
        }
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: kH5PoppinsLight.copyWith(color: Colors.black),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: decoration,
          child: Row(
            spacing: 8,
            children: [
              section == FocusSection.diffPyramid
                  ? DiffTriangleRedWidget(
                      allBlack: true,
                      noDecimals: true,
                      size: Diffsize.H3,
                      value: diff,
                    )
                  : Text(
                      "$score%",
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 18, color: Color(0xFF3F3F3F)),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
