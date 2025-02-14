import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class IndicatorsDepartmentScoresWidget extends ConsumerWidget {
  const IndicatorsDepartmentScoresWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    Indicator selectedIndicator = ref.watch(selectedIndicatorProvider);
    double ceoScore = displayData.ceoBenchmarks[selectedIndicator]!;
    double cSuiteScore = displayData.cSuiteBenchmarks[selectedIndicator]!;
    double employeeScore = displayData.employeeBenchmarks[selectedIndicator]!;

    return PerDepertmentScoresWidget(ceoScore: ceoScore, cSuiteScore: cSuiteScore, employeeScore: employeeScore);
  }
}

class OverallDepertmentBenchmarkWidget extends ConsumerWidget {
  const OverallDepertmentBenchmarkWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    double ceoScore = displayData.ceoBenchmarks[Indicator.companyIndex]!;
    double employeeScore = displayData.cSuiteBenchmarks[Indicator.companyIndex]!;
    double cSuiteScore = displayData.employeeBenchmarks[Indicator.companyIndex]!;
    double diff = displayData.diffScores[Indicator.companyIndex]!;

    return Column(
      children: [
        Text('CEO | C-Suite | Staff', style: kH4PoppinsRegular),
        PerDepertmentScoresWidget(ceoScore: ceoScore, cSuiteScore: cSuiteScore, employeeScore: employeeScore),
        SizedBox(height: 32),
        Text('Overall Differentiation', style: kH4PoppinsLight),
        SizedBox(height: 8),
        DiffTriangleRedWidget(value: diff, size: Diffsize.H3),
      ],
    );
  }
}

class PerDepertmentScoresWidget extends StatelessWidget {
  const PerDepertmentScoresWidget({
    super.key,
    required this.ceoScore,
    required this.cSuiteScore,
    required this.employeeScore,
  });

  final double ceoScore;
  final double cSuiteScore;
  final double employeeScore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$ceoScore%', style: TextStyle(color: Color(0xFF9FAE82), fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text(' | ', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text('$cSuiteScore%', style: TextStyle(color: Color(0xFFB3A986), fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text(' | ', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text('$employeeScore%', style: TextStyle(color: Color(0xFF7FAF8C), fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300))
        ],
      ),
    );
  }
}
