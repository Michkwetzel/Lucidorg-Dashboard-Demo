import 'package:flutter/material.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class TopOppertunitiesRow extends StatelessWidget {
  final String text;
  final String diff;
  final String score;

  const TopOppertunitiesRow({required this.text, required this.diff, required this.score, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: kGrayBoxDecoration,
          child: Text(
            text,
            style: kH5PoppinsLight,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: kGrayBoxDecoration,
          child: Row(
            children: [
              Text(
                score,
                style: kH5PoppinsLight,
              ),
              DiffTriangleRedWidget(
                size: Diffsize.H4,
                value: 23,
              ),
            ],
          ),
        )
      ],
    );
  }
}
