import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class IndicatorScoreBox extends ConsumerWidget {
  final String text;

  const IndicatorScoreBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = ref.watch(selectedIndicatorProvider);
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;
    
    double score = displayData.companyBenchmarks[selectedIndicator]!;

    return Container(
      width: 205,
      height: 105,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black, // Border color
          width: 1, // Border width
        ),
      ),
      child: Column(
        spacing: 8,
        children: [
          Text(text, style: kH3PoppinsRegular),
          Text('$score%', style: kH3TotalScoreLight),
        ],
      ),
    );
  }
}
