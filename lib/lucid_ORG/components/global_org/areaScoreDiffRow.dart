import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';

class AreaScoreDiffRow extends StatelessWidget {
  final String area;
  final String score;
  final String differentiation;
  final bool? showAllScores;

  const AreaScoreDiffRow({required this.area, required this.score, required this.differentiation, this.showAllScores, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(area, style: kH6PoppinsLight),
        Container(
          width: 32,
          height: 52,
          decoration: BoxDecoration(color: Color(0xFFB9D08F)),
          child: Text(score, style: kH6PoppinsLight),
        ),
        Container(
          width: 32,
          height: 52,
          decoration: BoxDecoration(color: Color(0xFFB9D08F)),
          child: Text(differentiation, style: kH6PoppinsLight),
        ),
      ],
    );
  }
}
