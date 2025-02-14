import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/home/charts/barChartWidget.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

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
      decoration: kboxShadowNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Benchmark', style: kH2PoppinsRegular),
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: 360,
                child: BarChartWidget(scores: [ceoIndex, cSuiteIndex, employeeIndex]),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Total Score', style: kH2PoppinsLight),
                SizedBox(height: 8),
                Text('${companyIndex.toStringAsFixed(1)}%', style: kH1TotalScoreRegular),
                SizedBox(height: 35),
                Text('Differentiation', style: kH3PoppinsLight),
                SizedBox(height: 8),
                DiffTriangleRedWidget(
                  size: Diffsize.H1,
                  value: indexDiff,
                )
              ])
            ],
          )
        ],
      ),
    );
  }
}
