import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class OverallScoreOverTimeRow extends StatelessWidget {
  final String category;
  final double score1;
  final double score2;

  const OverallScoreOverTimeRow({
    super.key,
    required this.category,
    required this.score1,
    required this.score2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170,
          child: Text(category, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
        ),
        SizedBox(
          width: 200.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 65,
                height: 38,
                decoration: kGrayBox,
                child: Center(child: Text('$score1%', style: TextStyle(color: Color(0xFF5478ED), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
              Container(
                width: 65,
                height: 38,
                decoration: kGrayBox,
                child: Center(child: Text('$score2%', style: TextStyle(color: Color(0xFF5478ED), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 125,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 40,
                decoration: kGrayBox,
                child: Center(child: Text('${(score1 - score2).abs().toStringAsFixed(1)}%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
            ],
          ),
        )
      ],
    );
  }
}
