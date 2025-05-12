import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/components/global_org/diffTriangleRedWidget.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class TotalScores extends ConsumerWidget {
  const TotalScores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    double companyIndex = displayData.companyBenchmarks[Indicator.companyIndex] ?? 50;
    double indexDiff = displayData.diffScores[Indicator.companyIndex] ?? 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 135,
          width: 250,
          padding: const EdgeInsets.all(24),
          decoration: kboxShadowNormal,
          child: Column(
            children: [
              Text('Total Score', style: kH2PoppinsLight),
              SizedBox(height: 8),
              Text('${companyIndex.toStringAsFixed(1)}%', style: kH1TotalScoreRegular),
            ],
          ),
        ),
        Container(
          height: 135,
          width: 250,
          padding: const EdgeInsets.all(24),
          decoration: kboxShadowNormal,
          child: Column(
            children: [
              Text('Differentiation', style: kH3PoppinsLight),
              SizedBox(height: 8),
              DiffTriangleRedWidget(
                size: Diffsize.H1,
                value: indexDiff,
              )
            ],
          ),
        ),
      ],
    );
  }
}
