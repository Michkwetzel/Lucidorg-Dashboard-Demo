import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/components/global/score_boxes/diff_box.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

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
            improve: true,
            score: true,
          ),
          SizedBox(height: 16),
          ImprovDeclineWidget(
            heading: 'Decline',
            improve: false,
            score: true,
          ),
        ],
      ),
    );
  }
}

class ImprovDeclineWidget extends ConsumerWidget {
  final String heading;
  final bool improve;
  final bool score;
  const ImprovDeclineWidget({super.key, required this.heading, required this.improve, required this.score});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric survey1 = ref.watch(scoreCompareProvider).survey1;
    SurveyMetric survey2 = ref.watch(scoreCompareProvider).survey2;



    List<Indicator> increaseList = ref.read(scoreCompareProvider.notifier).returnBiggestScoreIncrease();
    List<Indicator> decreaseList = ref.read(scoreCompareProvider.notifier).returnBiggestScoreDecrease();

    if (!score) {
      increaseList = ref.read(scoreCompareProvider.notifier).returnBiggestdiffIncrease();
      decreaseList = ref.read(scoreCompareProvider.notifier).returnBiggestdiffDecrease();
    }

    if (improve) {
      return Column(
        spacing: 16,
        children: [
          Text(heading, style: kH3PoppinsRegular),
          GrayDivider(
            width: 200,
          ),
          Row(
            children: [
              Text('Past', style: kH3PoppinsRegular),
              Text('Present', style: kH3PoppinsRegular),
            ],
          ),
          ScoresOverTimeRow(heading: increaseList[0].heading, score1: survey1.companyBenchmarks[increaseList[0]]!, score2: survey2.companyBenchmarks[increaseList[0]]!),
          ScoresOverTimeRow(heading: increaseList[1].heading, score1: survey1.companyBenchmarks[increaseList[1]]!, score2: survey2.companyBenchmarks[increaseList[1]]!),
          ScoresOverTimeRow(heading: increaseList[2].heading, score1: survey1.companyBenchmarks[increaseList[2]]!, score2: survey2.companyBenchmarks[increaseList[2]]!),
        ],
      );
    } else {
      return Column(
        spacing: 16,
        children: [
          Text(heading, style: kH3PoppinsRegular),
          GrayDivider(
            width: 200,
          ),
          Row(
            children: [
              Text('Past', style: kH3PoppinsRegular),
              Text('Present', style: kH3PoppinsRegular),
            ],
          ),
          DiffOverTimeRow(heading: decreaseList[0].heading, diff1: survey1.diffScores[increaseList[0]]!, diff2: survey2.diffScores[increaseList[0]]!),
          DiffOverTimeRow(heading: decreaseList[1].heading, diff1: survey1.diffScores[increaseList[1]]!, diff2: survey2.diffScores[increaseList[1]]!),
          DiffOverTimeRow(heading: decreaseList[2].heading, diff1: survey1.diffScores[increaseList[2]]!, diff2: survey2.diffScores[increaseList[2]]!),
        ],
      );
    }
  }
}

class ScoresOverTimeRow extends StatelessWidget {
  final String heading;
  final double score1;
  final double score2;
  const ScoresOverTimeRow({super.key, required this.heading, required this.score1, required this.score2});

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
        ScoreBox(score: score1, width: 60, height: 50, textSize: 14, fontWeight: FontWeight.w300),
        ScoreBox(score: score2, width: 60, height: 50, textSize: 14, fontWeight: FontWeight.w300)
      ],
    );
  }
}

class DiffOverTimeRow extends StatelessWidget {
  final String heading;
  final double diff1;
  final double diff2;
  const DiffOverTimeRow({super.key, required this.heading, required this.diff1, required this.diff2});

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
        DiffBox(diff: diff1, width: 60, height: 50, textSize: 14, fontWeight: FontWeight.w300),
        DiffBox(diff: diff2, width: 60, height: 50, textSize: 14, fontWeight: FontWeight.w300)
      ],
    );
  }
}
