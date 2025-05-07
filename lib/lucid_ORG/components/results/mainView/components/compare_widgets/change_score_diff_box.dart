import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class ChangeScoreDiffBox extends StatelessWidget {
  const ChangeScoreDiffBox({
    super.key,
    required this.type,
    required this.scoreChange,
  });

  final Compare type;
  final double scoreChange;

  @override
  Widget build(BuildContext context) {
    Color arrowColor;
    IconData icon;
    Decoration boxDecoration;

    if (type == Compare.score) {
      if (scoreChange < 0) {
        arrowColor = Colors.red;
        boxDecoration = kRedBox;
        icon = Icons.arrow_downward;
      } else if (scoreChange > 0) {
        arrowColor = Colors.green;
        boxDecoration = kGreenBox;
        icon = Icons.arrow_upward;
      } else {
        arrowColor = Colors.grey;
        boxDecoration = kGrayBox;
        icon = Icons.arrow_upward;
      }
    } else {
      if (scoreChange < 0) {
        arrowColor = Colors.green;
        boxDecoration = kGreenBox;
        icon = Icons.arrow_upward;
      } else if (scoreChange > 0) {
        arrowColor = Colors.red;
        boxDecoration = kRedBox;
        icon = Icons.arrow_downward;
      } else {
        arrowColor = Colors.grey;
        boxDecoration = kGrayBox;
        icon = Icons.arrow_upward;
      }
    }

    return SizedBox(
      width: 125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: arrowColor,
          ),
          SizedBox(
            width: 4,
          ),
          Container(
            width: 60,
            height: 40,
            decoration: boxDecoration,
            child: Center(
              child: Text(
                scoreChange.toStringAsFixed(1),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GrayBox extends StatelessWidget {
  const GrayBox({
    super.key,
    required this.value,
    required this.width,
    required this.height,
  });

  final double value;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: kGrayBox,
      child: Center(
        child: Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
