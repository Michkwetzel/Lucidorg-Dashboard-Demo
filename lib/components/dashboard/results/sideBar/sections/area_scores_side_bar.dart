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
              HighLevelScoresRow(category: 'Purpose-Driven Everything', score: 65.7, diff: 18),
              HighLevelScoresRow(category: "Growth Alignment", score: 63.1, diff: 19),
              HighLevelScoresRow(category: 'Aligned Org Structure', score: 54.1, diff: 15),
              HighLevelScoresRow(category: "Collaborative Processes", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Collaborative KPIs", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Aligned Tech Stack", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Cross-Fxn Comms", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Empowered Leadership", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Engaged Community", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Meeting Efficacy", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Cross-Fxn Acc", score: 63.1, diff: 19),
              GrayDivider(),
              OverallScoresRow(category: 'Overall', score: 43.6, diff: 12)
            ],
          ),
        ],
      ),
    );
  }
}
