// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/cat_score_diff_text_heading.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/highLevelScoresRow.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/overallScoresRow.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';

class HighLevelScoresWidget extends StatelessWidget {
  const HighLevelScoresWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('High Level Scores', style: kH3PoppinsRegular),
        SizedBox(height: 30),
        CatScoreDiffTextHeading(),
        SizedBox(height: 4),
        Divider(color: Color(0xFFC7C7C7), thickness: 1),
        SizedBox(height: 12),
        HighLevelScoresRow(
          highLevelScore: true,
          category: 'Alignment',
          score: 65.7,
          diff: 18,
        ),
        SizedBox(height: 12),
        HighLevelScoresRow(
          highLevelScore: true,
          category: 'People',
          score: 70.7,
          diff: 18,
        ),
        SizedBox(height: 12),
        HighLevelScoresRow(
          highLevelScore: true,
          category: 'Process',
          score: 45.7,
          diff: 18,
        ),
        SizedBox(height: 12),
        HighLevelScoresRow(
          highLevelScore: true,
          category: 'Leadership',
          score: 56.7,
          diff: 18,
        ),
        SizedBox(height: 12),
        GrayDivider(),
        SizedBox(height: 12),
        OverallScoresRow(
          category: 'Overall',
          score: 56.7,
          diff: 18,
        ),
      ],
    );
  }
}
