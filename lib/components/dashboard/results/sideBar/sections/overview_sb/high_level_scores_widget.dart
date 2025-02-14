// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/cat_score_diff_text_heading.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/overview_sb/highLevelScoresRow.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class HighLevelScoresWidget extends ConsumerWidget {
  const HighLevelScoresWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    return Column(
      children: [
        Text('High Level Scores', style: kH3PoppinsRegular),
        SizedBox(height: 30),
        CategoryScoreDiffTextHeading(),
        SizedBox(height: 4),
        Divider(color: Color(0xFFC7C7C7), thickness: 1),
        SizedBox(height: 12),
        HighLevelScoresRow(
          category: 'Alignment',
          score: displayData.companyBenchmarks['align']!,
          diff: displayData.diffScores['align']!,
        ),
        SizedBox(height: 12),
        HighLevelScoresRow(
          category: 'People',
          score: displayData.companyBenchmarks['people']!,
          diff: displayData.diffScores['people']!,
        ),
        SizedBox(height: 12),
        HighLevelScoresRow(
          category: 'Process',
          score: displayData.companyBenchmarks['process']!,
          diff: displayData.diffScores['process']!,
        ),
        SizedBox(height: 12),
        HighLevelScoresRow(
          category: 'Leadership',
          score: displayData.companyBenchmarks['leadership']!,
          diff: displayData.diffScores['leadership']!,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
