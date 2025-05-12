import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/components/home/charts/barChartWidget.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class DepartmentScoreWidget extends ConsumerWidget {
  final DashboardSection section;
  const DepartmentScoreWidget({
    required this.section,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    double ceoIndex = displayData.ceoBenchmarks[Indicator.companyIndex] ?? 50;
    double cSuiteIndex = displayData.cSuiteBenchmarks[Indicator.companyIndex] ?? 50;
    double employeeIndex = displayData.employeeBenchmarks[Indicator.companyIndex] ?? 50;

    if (section == DashboardSection.home) {
      return Container(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Department Scores",
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 24),
            ),
            SizedBox(
              height: 270,
              width: 330,
              child: BarChartWidget(scores: [ceoIndex, cSuiteIndex, employeeIndex]),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 330,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 40,
          children: [
            Text(
              "Department Scores",
              style: kH2PoppinsRegular,
            ),
            Expanded(child: BarChartWidget(scores: [ceoIndex, cSuiteIndex, employeeIndex])),
          ],
        ),
      );
    }
  }
}
