import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/impact/compare_widgets/change_score_diff_box.dart';
import 'package:platform_front/config/constants.dart';
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
        ChangeScoreDiffBox(type: type, scoreChange: type == Compare.score ? scoreChange[indicator]! : diffChange[indicator]!)
      ],
    );
  }
}

class CompareScoreMiddleBox extends StatelessWidget {
  const CompareScoreMiddleBox({
    super.key,
    required this.value,
    required this.width,
    required this.height,
    required this.type,
  });

  final double value;
  final double width;
  final double height;
  final Compare type;

  @override
  Widget build(BuildContext context) {
    String valueDisplay = '${value.toStringAsFixed(1)}%';
    if (type == Compare.diff) {
      valueDisplay = '~${value.toStringAsFixed(1)}';
    }

    return Container(
      width: width,
      height: height,
      decoration: kGrayBox,
      child: Center(
        child: Text(
          valueDisplay,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
    
  }
}
