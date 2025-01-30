import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class AreaScoreBox extends StatelessWidget {
  final String text;
  final double score;

  const AreaScoreBox({
    super.key,
    required this.text,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 105,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black, // Border color
          width: 1, // Border width
        ),
      ),
      child: Column(
        spacing: 8,
        children: [
          Text(text, style: kH3PoppinsRegular),
          Text('$score%', style: kH3TotalScoreLight),
        ],
      ),
    );
  }
}
