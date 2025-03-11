import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/home/charts/pieChartWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class ParticipationWidgetNew extends ConsumerWidget {
   const ParticipationWidgetNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    double? nStartedButNotFinish = displayData.nStarted - displayData.nSubmitted;
    double? nSurveys = displayData.nSurveys;
    double? nSubmitted = displayData.nSubmitted;
    double? nNotStarted = nSurveys - displayData.nStarted;
    double? participationRate = nSurveys > 0 ? double.parse((nSubmitted / nSurveys * 100).toStringAsFixed(1)) : null;

    double startedPercentage = nSurveys > 0 ? double.parse((nStartedButNotFinish / nSurveys * 100).toStringAsFixed(1)) : 30;
    startedPercentage = startedPercentage < 0 ? 30 : startedPercentage;

    double submittedPercentage = nSurveys > 0 ? double.parse((nSubmitted / nSurveys * 100).toStringAsFixed(1)) : 40;
    submittedPercentage = submittedPercentage < 0 ? 40 : submittedPercentage;

    double notStartedPercentage = nSurveys > 0 ? double.parse((nNotStarted / nSurveys * 100).toStringAsFixed(1)) : 30;
    notStartedPercentage = notStartedPercentage < 0 ? 30 : notStartedPercentage;

    return Container(
      height: 400,
      width: 400,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Participation Rate:', style: TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.w400, fontSize: 30, color: Color(0xFF494949))),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text('$participationRate%', style: kH2PoppinsLight),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.topCenter,
              child: PieChartWidget(
                colors: [const Color(0xFFA6A6A6), const Color(0xFFD9D9D9), const Color(0xFFA2B088)],
                values: [notStartedPercentage, startedPercentage, submittedPercentage],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem('Submitted', const Color(0xFFA2B088)),
              _buildLegendItem('Started', const Color(0xFFD9D9D9)),
              _buildLegendItem('Not Started', const Color(0xFFA6A6A6)),
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
