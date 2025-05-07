import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/components/compare_widgets/change_score_diff_box.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/components/compare_widgets/score_over_time_row.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class OverallScoreOverTimeRow extends ConsumerWidget {
  final Indicator indicator;
  final Compare type;

  const OverallScoreOverTimeRow({
    super.key,
    required this.indicator,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric survey1 = ref.watch(scoreCompareProvider).survey1Data;
    SurveyMetric survey2 = ref.watch(scoreCompareProvider).survey2Data;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170,
          child: Text(indicator.heading, style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
        ),
        SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.5),
                child: CompareScoreMiddleBox(value: type == Compare.score ? survey1.companyBenchmarks[indicator]! : survey1.diffScores[indicator]!, width: 100, height: 40, type: type),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.5),
                child: CompareScoreMiddleBox(value: type == Compare.score ? survey2.companyBenchmarks[indicator]! : survey2.diffScores[indicator]!, width: 100, height: 40, type: type),
              ),
            ],
          ),
        ),
        ChangeScoreDiffBox(
            type: type,
            scoreChange: type == Compare.score ? survey2.companyBenchmarks[indicator]! - survey1.companyBenchmarks[indicator]! : survey2.diffScores[indicator]! - survey1.diffScores[indicator]!)
      ],
    );
  }
}
