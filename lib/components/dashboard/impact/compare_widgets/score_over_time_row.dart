import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/impact/compare_widgets/change_score_diff_box.dart';
import 'package:platform_front/components/dashboard/impact/main_view/score_over_time/score_over_time_MV.dart';
import 'package:platform_front/components/global/score_boxes/diff_box.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class ScoreOverTimeRow extends ConsumerWidget {
  final Indicator indicator;
  final Compare type; //If score or diff

  const ScoreOverTimeRow({
    super.key,
    required this.indicator,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric survey1 = ref.watch(scoreCompareProvider).survey1Data;
    SurveyMetric survey2 = ref.watch(scoreCompareProvider).survey2Data;
    Map<Indicator, double> diffChange = ref.watch(scoreCompareProvider).diffChange;
    Map<Indicator, double> scoreChange = ref.watch(scoreCompareProvider).scoreChange;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170,
          child: Text(indicator.heading, style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
        ),
        SizedBox(
          width: 200.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              type == Compare.score
                  ? ScoreBox(score: survey1.companyBenchmarks[indicator]!, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300)
                  : DiffBox(diff: survey1.diffScores[indicator]!, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300),
              type == Compare.score
                  ? ScoreBox(score: survey2.companyBenchmarks[indicator]!, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300)
                  : DiffBox(diff: survey2.diffScores[indicator]!, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300),
            ],
          ),
        ),
        type == Compare.score ? ChangeScoreDiffBox(type: type, scoreChange: scoreChange[indicator]!) : ChangeScoreDiffBox(type: type, scoreChange: diffChange[indicator]!)
      ],
    );
  }
}
