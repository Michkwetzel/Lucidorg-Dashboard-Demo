import 'package:flutter/material.dart';
import 'package:platform_front/components/global/score_boxes/diff_box.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class ScoresOverTimeSB extends StatelessWidget {
  const ScoresOverTimeSB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25).copyWith(top: 40),
      child: Column(
        spacing: 16,
        children: [
          Text('Scores Over Time', style: kH2PoppinsLight),
          SizedBox(height: 16),
          ImprovDeclineWidget(
            heading: 'Improvement',
          ),
          SizedBox(height: 16),
          ImprovDeclineWidget(
            heading: 'Decline',
          ),
        ],
      ),
    );
  }
}

class ImprovDeclineWidget extends StatelessWidget {
  final String heading;
  const ImprovDeclineWidget({
    super.key,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Text(heading, style: kH3PoppinsRegular),
        ScoresOverTimeRow(heading: 'Meeting Efficacy', score: 65.7, diff: 23.5),
        ScoresOverTimeRow(heading: 'X-Functional Comms', score: 65.7, diff: 23.5),
        ScoresOverTimeRow(heading: 'Collaborative KPI\'s', score: 65.7, diff: 23.5),
      ],
    );
  }
}

class ScoresOverTimeRow extends StatelessWidget {
  final String heading;
  final double score;
  final double diff;
  const ScoresOverTimeRow({super.key, required this.heading, required this.score, required this.diff});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            heading,
            style: kH5PoppinsLight,
          ),
        ),
        ScoreBox(score: score, width: 60, height: 50, textSize: 14, fontWeight: FontWeight.w300),
        DiffBox(diff: diff, width: 60, height: 50, textSize: 14, fontWeight: FontWeight.w300)
      ],
    );
  }
}
