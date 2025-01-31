import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/companyInfo/styledDropdown.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';

class ScoreOverTimeMV extends StatelessWidget {
  const ScoreOverTimeMV({super.key});

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
              ScoreOverTimeRow(category: 'Alignment', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'Process', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'People', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'KIP', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'Purpouse', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'Leadership', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'Engagement', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'Tech', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'Process', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'Process', score1: 65.7, score2: 45.7),
              ScoreOverTimeRow(category: 'Alignment', score1: 65.7, score2: 45.7),
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
  final double score1;
  final double score2;

  const ScoreOverTimeRow({
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
                decoration: kScoreGreenBox,
                child: Center(child: Text('$score1%', style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
              Container(
                width: 65,
                height: 38,
                decoration: kDiffRedBox,
                child: Center(child: Text('~$score2%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
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
                child: Center(child: Text('${(score1 - score2).abs()}%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
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
                child: Center(child: Text('${(score1 - score2).abs()}%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
            ],
          ),
        )
      ],
    );
  }
}
