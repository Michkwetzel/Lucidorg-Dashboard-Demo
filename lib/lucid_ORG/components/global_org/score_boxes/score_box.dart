import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';

class ScoreBox extends StatelessWidget {
  // Changed to StatelessWidget since no state management needed
  final double height;
  final double width;
  final double score;
  final double textSize;
  final FontWeight fontWeight;
  final double companyIndex;

  const ScoreBox({
    super.key,
    required this.score,
    required this.width,
    required this.height,
    required this.textSize,
    required this.fontWeight,
    this.companyIndex = 0,
  });

  BoxDecoration _getDecoration() {
    if (score < 0 || score > 100) {
      return kGrayBox; // Handle invalid scores
    }

    if (score > companyIndex) {
      return kGreenBox;
    } else {
      double diffFromIndex = companyIndex - score;
      if (diffFromIndex < 5) {
        return kGrayBox;
      } else if (diffFromIndex < 10) {
        return kYellowBox;
      } else if (diffFromIndex < 15) {
        return kRedBox;
      } else {
        return kRedBox;
      }
    }

    // if (score < 40) {
    //   return kRedBox;
    // } else if (score < 50) {
    //   return kYellowBox;
    // } else if (score < 60) {
    //   return kGrayBox;
    // } else {
    //   return kGreenBox;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: _getDecoration(),
      child: Center(
        child: Text(
          '${score.toStringAsFixed(1)}%', // Format to 1 decimal place
          style: TextStyle(
            fontSize: textSize,
            fontFamily: 'Poppins',
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
