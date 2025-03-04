import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

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

    if (type == Compare.score) {
      if (scoreChange < 0) {
        arrowColor = Colors.red;
        icon = Icons.arrow_downward;
      } else if (scoreChange > 0) {
        arrowColor = Colors.green;
        icon = Icons.arrow_upward;
      } else {
        arrowColor = Colors.grey;
        icon = Icons.arrow_upward;
      }
    } else {
      if (scoreChange < 0) {
        arrowColor = Colors.green;
        icon = Icons.arrow_upward;
      } else if (scoreChange > 0) {
        arrowColor = Colors.red;
        icon = Icons.arrow_downward;
      } else {
        arrowColor = Colors.grey;
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
            decoration: kGrayBox,
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
          ),
        ],
      ),
    );
  }
}
