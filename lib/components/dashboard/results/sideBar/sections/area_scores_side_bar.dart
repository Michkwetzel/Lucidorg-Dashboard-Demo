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
              HighLevelScoresRow(category: 'Alignment', score: 65.7, diff: 18),
              HighLevelScoresRow(category: "Process", score: 63.1, diff: 19),
              HighLevelScoresRow(category: 'People', score: 54.1, diff: 15),
              HighLevelScoresRow(category: "Process", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Process", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Process", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Process", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Process", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Process", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Process", score: 63.1, diff: 19),
              HighLevelScoresRow(category: "Process", score: 63.1, diff: 19),
              GrayDivider(),
              OverallScoresRow(category: 'Overall', score: 43.6, diff: 12)
            ],
          ),
        ],
      ),
    );
  }
}
