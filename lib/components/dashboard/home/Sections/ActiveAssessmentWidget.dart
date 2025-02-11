import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/home/charts/pieChartWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';
import 'package:platform_front/notifiers/surveyMetrics/survey_metrics_provider.dart';

class ActiveAssessmentWidget extends ConsumerWidget {
  ActiveAssessmentWidget({super.key});

  final List<PieChartSectionData> sections = [
    PieChartSectionData(
      value: 35,
      title: '35%',
      color: const Color(0xFFA2B088),
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value: 40,
      title: '40%',
      color: const Color(0xFFA6A6A6),
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value: 25,
      title: '25%',
      color: const Color(0xFFD9D9D9),
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    int started = displayData.nStarted;
    int nSurveys = displayData.nSurveys;
    int submitted = displayData.nCSuiteFinished;

    return Container(
      height: 400,
      width: 400,
      padding: const EdgeInsets.all(16),
      decoration: kboxShadowNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Participation Rate:', style: kH2PoppinsRegular),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: const Text("73%", style: kH2PoppinsLight),
          ),
          const Flexible(
            child: Align(
              alignment: Alignment.topCenter,
              child: PieChartWidget(
                values: [10, 15, 75],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem('Submitted', const Color(0xFFA2B088)),
              _buildLegendItem('Started', const Color(0xFFA6A6A6)),
              _buildLegendItem('Not Started', const Color(0xFFD9D9D9)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
