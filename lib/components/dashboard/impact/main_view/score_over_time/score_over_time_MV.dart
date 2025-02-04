import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/companyInfo/styledDropdown.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/components/global/score_boxes/diff_box.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/constants.dart';

class ScoreOverTimeMV extends StatelessWidget {
  const ScoreOverTimeMV({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 170, child: Text('Impact Chart', style: kH3PoppinsRegular)),
              Row(
                spacing: 16,
                children: [
                  SizedBox(height: 40, width: 75, child: StyledDropdown(items: ['Q1', 'Q2'], onChanged: (p0) {}, initalValue: 'Q1')),
                  Text('vs', style: kH5PoppinsRegular),
                  SizedBox(height: 40, width: 75, child: StyledDropdown(items: ['Q1', 'Q2'], onChanged: (p0) {}, initalValue: 'Q1')),
                ],
              ),
              SizedBox(width: 125, child: Text('Difference', style: kH3PoppinsRegular)),
            ],
          ),
          GrayDivider(),
          SizedBox(
            height: 8,
          ),
          Column(
            spacing: 16,
            children: [
              ScoreOverTimeRow(category: 'Org Alignment', value1: 2, value2: 33),
              ScoreOverTimeRow(category: 'Growth Alignment', value1: 23, value2: 12),
              ScoreOverTimeRow(category: 'Collaborative KPI', value1: 11, value2: 12),
              ScoreOverTimeRow(category: 'Engaged Community', value1: 23, value2: 33),
              ScoreOverTimeRow(category: 'X-Func Communication', value1: 3, value2: 42),
              ScoreOverTimeRow(category: 'X-Funct Accountability', value1: 3, value2: 2),
              ScoreOverTimeRow(category: 'Aligned Tech', value1: 24, value2: 42),
              ScoreOverTimeRow(category: 'Collaborative Processes', value1: 49, value2: 45.7),
              ScoreOverTimeRow(category: 'Meeting Efficacy', value1: 42, value2: 12),
              ScoreOverTimeRow(category: 'Purpose Led Everything', value1: 32, value2: 45.7),
              ScoreOverTimeRow(category: 'Empowered Leadership', value1: 2, value2: 45.3),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          GrayDivider(),
          SizedBox(
            height: 8,
          ),
          OverallScoreOverTimeRow(
            category: 'Overall',
            score1: 43.5,
            score2: 50.6,
          )
        ],
      ),
    );
  }
}

class ScoreOverTimeRow extends StatelessWidget {
  final String category;
  final double value1;
  final double value2;
  final bool scores;

  const ScoreOverTimeRow({
    super.key,
    required this.category,
    required this.value1,
    required this.value2,
    this.scores = true,
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
              scores
                  ? ScoreBox(score: value1, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300)
                  : DiffBox(diff: value1, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300),
              scores
                  ? ScoreBox(score: value2, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300)
                  : DiffBox(diff: value2, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300),
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
                child: Center(child: Text('${(value1 - value2).abs().toStringAsFixed(1)}%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
            ],
          ),
        )
      ],
    );
  }
}

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
