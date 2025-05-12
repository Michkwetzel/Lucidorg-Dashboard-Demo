import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/global_org/diffTriangleRedWidget.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class CurrentActionAreaWidget extends ConsumerWidget {
  const CurrentActionAreaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric surveyMetric = ref.watch(metricsDataProvider).surveyMetric;
    Indicator highestIndicator = surveyMetric.getHighestScoreIndicator();

    double score = surveyMetric.companyBenchmarks[highestIndicator]!;
    double diff = surveyMetric.diffScores[highestIndicator]!;


    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: kboxShadowNormal,
      child: Column(children: [
        const Text(
          'Healthiest Indicator',
          style: kH2PoppinsRegular,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFDED6A3),
          ),
          child: Text(
            highestIndicator.heading,
            style: kH5PoppinsLight,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Total Score', style: kH6PoppinsLight),
                Text('$score%', style: kH6PoppinsLight),
              ],
            ),
            Column(
              children: [
                Text('Differentiation', style: kH6PoppinsLight),
                DiffTriangleRedWidget(
                  size: Diffsize.H4,
                  value: diff,
                )
              ],
            )
          ],
        )
      ]),
    );
  }
}
