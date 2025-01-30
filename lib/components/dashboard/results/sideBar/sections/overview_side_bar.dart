// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/cat_score_diff_text_heading.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/highLevelScoresRow.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/overallScoresRow.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class OverViewSBResults extends StatelessWidget {
  const OverViewSBResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Overall Score", style: kH2PoppinsLight),
          SizedBox(height: 8),
          Text('55.7%', style: kH2TotalScoreLight),
          SizedBox(height: 60),
          Text('Overall Differentiation', style: kH3PoppinsLight),
          SizedBox(height: 8),
          DiffTriangleRedWidget(value: 38, size: Diffsize.H2),
          SizedBox(height: 60),
          Text('High Level Scores', style: kH3PoppinsRegular),
          SizedBox(height: 30),
          CatScoreDiffTextHeading(),
          SizedBox(height: 4),
          Divider(color: Color(0xFFC7C7C7), thickness: 1),
          SizedBox(height: 12),
          HighLevelScoresRow(
            category: 'Alignment',
            score: 65.7,
            diff: 18,
          ),
          SizedBox(height: 12),
          HighLevelScoresRow(
            category: 'Process',
            score: 70.7,
            diff: 18,
          ),
          SizedBox(height: 12),
          HighLevelScoresRow(
            category: 'People',
            score: 45.7,
            diff: 18,
          ),
          SizedBox(height: 12),
          HighLevelScoresRow(
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
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
