import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/home/charts/barChartWidget.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/indicators/department_scores_widget.dart';
import 'package:platform_front/lucid_ORG/components/global_org/diffTriangleRedWidget.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class BenchmarkWidget extends ConsumerWidget {
  BenchmarkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    double ceoIndex = displayData.ceoBenchmarks[Indicator.companyIndex] ?? 50;
    double cSuiteIndex = displayData.cSuiteBenchmarks[Indicator.companyIndex] ?? 50;
    double employeeIndex = displayData.employeeBenchmarks[Indicator.companyIndex] ?? 50;
    double companyIndex = displayData.companyBenchmarks[Indicator.companyIndex] ?? 50;
    double indexDiff = displayData.diffScores[Indicator.companyIndex] ?? 1;

    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 300,
        width: 360,
        child: BarChartWidget(scores: [ceoIndex, cSuiteIndex, employeeIndex]),
      ),
    );
  }
}
