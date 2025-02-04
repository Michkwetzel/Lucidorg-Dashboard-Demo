import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/cat_score_diff_text_heading.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/highLevelScoresRow.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/overallScoresRow.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';

class AreaScoresSideBar extends StatelessWidget {
  const AreaScoresSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
      child: Column(
        children: [
          Text('Area Scores', style: kH2PoppinsLight),
          SizedBox(
            height: 40,
          ),
          CatScoreDiffTextHeading(),
          Column(
            spacing: 12,
            children: [
              GrayDivider(),
              HighLevelScoresRow(category: 'Org Alignment', score: 65.7, diff: 18),
              HighLevelScoresRow(category: "Growth Alignment", score: 23, diff: 19),
              HighLevelScoresRow(category: 'Collaborative KPI', score: 80, diff: 15),
              HighLevelScoresRow(category: "Engaged Community", score: 54, diff: 9),
              HighLevelScoresRow(category: "X-Func Communication", score: 43, diff: 34),
              HighLevelScoresRow(category: "X-Funct Accountability", score: 45.1, diff: 1),
              HighLevelScoresRow(category: "Aligned Tech", score: 76, diff: 19),
              HighLevelScoresRow(category: "Collaborative Processes", score: 80, diff: 23),
              HighLevelScoresRow(category: "Meeting Efficacy", score: 23, diff: 25),
              HighLevelScoresRow(category: "Purpose Led Everything", score: 63.1, diff: 12),
              HighLevelScoresRow(category: "Empowered Leadership", score: 37, diff: 2),
              GrayDivider(),
              OverallScoresRow(category: 'Overall', score: 43.6, diff: 12)
            ],
          ),
        ],
      ),
    );
  }
}
