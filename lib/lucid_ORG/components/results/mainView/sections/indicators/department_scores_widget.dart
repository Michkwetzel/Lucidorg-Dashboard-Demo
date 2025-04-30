import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class IndicatorsDepartmentScoresWidget extends ConsumerWidget {
  const IndicatorsDepartmentScoresWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    Indicator selectedIndicator = ref.watch(selectedIndicatorProvider);
    double ceoScore = displayData.ceoBenchmarks[selectedIndicator]!;
    double cSuiteScore = displayData.cSuiteBenchmarks[selectedIndicator]!;
    double employeeScore = displayData.employeeBenchmarks[selectedIndicator]!;

    return PerDepertmentScoresWidget(
      ceoScore: ceoScore,
      cSuiteScore: cSuiteScore,
      employeeScore: employeeScore,
      bold: true,
    );
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

    return Column(
      children: [
        PerDepertmentScoresWidget(ceoScore: ceoScore, cSuiteScore: cSuiteScore, employeeScore: employeeScore),
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
    this.bold = false,
  });

  final double ceoScore;
  final double cSuiteScore;
  final double employeeScore;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 60, child: Center(child: Text('CEO', style: bold ? kH3PoppinsRegular : kH3PoppinsLight))),
                Text('|', style: kH4PoppinsLight),
                SizedBox(width: 100, child: Center(child: Text('C-Suite', style: bold ? kH3PoppinsRegular : kH3PoppinsLight))),
                Text('|', style: kH4PoppinsLight),
                SizedBox(width: 70, child: Center(child: Text('Team', style: bold ? kH3PoppinsRegular : kH3PoppinsLight))),
              ],
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 60, child: Center(child: Text('$ceoScore%', style: TextStyle(color: Color(0xFF9FAE82), fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300)))),
                Text('|', style: kH4PoppinsLight),
                SizedBox(width: 100, child: Center(child: Text('$cSuiteScore%', style: TextStyle(color: Color(0xFFB3A986), fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300)))),
                Text('|', style: kH4PoppinsLight),
                SizedBox(width: 70, child: Center(child: Text('$employeeScore%', style: TextStyle(color: Color(0xFF7FAF8C), fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300))))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
