import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/global_org/diffTriangleRedWidget.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class IndicatorDiffBox extends ConsumerWidget {
  final String text;
  final double diff;

  const IndicatorDiffBox({
    super.key,
    required this.text,
    required this.diff,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = ref.watch(selectedIndicatorProvider);
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    double diff = displayData.diffScores[selectedIndicator]!;
    
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
          Text(text, style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 22)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DiffTriangleRedWidget(
                value: diff,
                size: Diffsize.H1,
                allRed: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}
