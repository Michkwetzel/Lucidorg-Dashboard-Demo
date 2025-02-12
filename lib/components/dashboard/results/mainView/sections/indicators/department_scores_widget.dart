import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class DepartmentScoresWidget extends ConsumerWidget {
  const DepartmentScoresWidget({super.key});

  final double fontSize = 20;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    Indicator selectedIndicator = ref.watch(selectedIndicatorProvider);
    double ceoScore = displayData.ceoBenchmarks[selectedIndicator.asString]!;
    double cSuiteScore = displayData.cSuiteBenchmarks[selectedIndicator.asString]!;
    double employeeScore = displayData.employeeBenchmarks[selectedIndicator.asString]!;

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$ceoScore%', style: TextStyle(color: Color(0xFF9FAE82), fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text(' | ', style: TextStyle(color: Colors.black, fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text('$cSuiteScore%', style: TextStyle(color: Color(0xFFB3A986), fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text(' | ', style: TextStyle(color: Colors.black, fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text('$employeeScore%', style: TextStyle(color: Color(0xFF7FAF8C), fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300))
        ],
      ),
    );
  }
}
