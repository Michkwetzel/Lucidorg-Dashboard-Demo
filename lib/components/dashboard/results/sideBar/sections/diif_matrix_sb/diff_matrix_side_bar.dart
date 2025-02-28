import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/indicators/department_scores_widget.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class DiffMatrixSideBar extends ConsumerWidget {
  const DiffMatrixSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;
    Indicator selectedIndicator = ref.watch(selectedDiffMatrixProvider);

    double ceoScore = displayData.ceoBenchmarks[selectedIndicator]!;
    double employeeScore = displayData.cSuiteBenchmarks[selectedIndicator]!;
    double cSuiteScore = displayData.employeeBenchmarks[selectedIndicator]!;
    double indicatorScore = displayData.companyBenchmarks[selectedIndicator]!;
    double diff = displayData.diffScores[selectedIndicator]!;

    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(selectedIndicator.heading, style: kH2PoppinsLight, textAlign: TextAlign.center),
          GrayDivider(width: 200),
          Text("Benchmark", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 24)),
          Text('$indicatorScore%', style: kH2TotalScoreLight),
          SizedBox(height: 8),
          PerDepertmentScoresWidget(ceoScore: ceoScore, cSuiteScore: cSuiteScore, employeeScore: employeeScore),
          SizedBox(height: 8),
          Text('Differentiation', style: kH3PoppinsLight),
          DiffTriangleRedWidget(value: diff, size: Diffsize.H3),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class TopTextWidgetDiffMatrixsb extends ConsumerWidget {
  const TopTextWidgetDiffMatrixsb({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = ref.watch(selectedDiffMatrixProvider);

    return Text(
      selectedIndicator.heading,
      style: kH2PoppinsLight,
      textAlign: TextAlign.center,
    );
  }
}
