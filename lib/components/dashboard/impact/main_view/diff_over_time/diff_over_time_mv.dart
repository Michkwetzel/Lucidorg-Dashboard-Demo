import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/companyInfo/styledDropdown.dart';
import 'package:platform_front/components/dashboard/impact/main_view/score_over_time/score_over_time_MV.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';

class DiffOverTimeMv extends StatelessWidget {
  const DiffOverTimeMv({super.key});

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
              ScoreOverTimeRow(category: 'Org Alignment', value1: 2, value2: 33, scores: false),
              ScoreOverTimeRow(category: 'Growth Alignment', value1: 23, value2: 12, scores: false),
              ScoreOverTimeRow(category: 'Collaborative KPI', value1: 11, value2: 12, scores: false),
              ScoreOverTimeRow(category: 'Engaged Community', value1: 23, value2: 33, scores: false),
              ScoreOverTimeRow(category: 'X-Func Communication', value1: 3, value2: 42, scores: false),
              ScoreOverTimeRow(category: 'X-Funct Accountability', value1: 3, value2: 2, scores: false),
              ScoreOverTimeRow(category: 'Aligned Tech', value1: 24, value2: 42, scores: false),
              ScoreOverTimeRow(category: 'Collaborative Processes', value1: 49, value2: 45.7, scores: false),
              ScoreOverTimeRow(category: 'Meeting Efficacy', value1: 42, value2: 12, scores: false),
              ScoreOverTimeRow(category: 'Purpose Led Everything', value1: 32, value2: 45.7, scores: false),
              ScoreOverTimeRow(category: 'Empowered Leadership', value1: 2, value2: 45.7, scores: false),
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
