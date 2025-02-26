import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class DiffOverTimeSb extends ConsumerWidget {
  const DiffOverTimeSb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    SurveyMetric survey1 = ref.watch(scoreCompareProvider).survey1;
    SurveyMetric survey2 = ref.watch(scoreCompareProvider).survey2;
    
    for (double value in survey1.companyBenchmarks.values) {

    }

    return Padding(
      padding: const EdgeInsets.all(25).copyWith(top: 40),
      child: Column(
        spacing: 16,
        children: [
          Text(
            'Differentiation\nOver Time',
            style: kH2PoppinsLight,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ImprovDeclineWidget(
            heading: 'Improvement',
          ),
          SizedBox(height: 16),
          ImprovDeclineWidget(
            heading: 'Decline',
          ),
        ],
      ),
    );
  }
}
