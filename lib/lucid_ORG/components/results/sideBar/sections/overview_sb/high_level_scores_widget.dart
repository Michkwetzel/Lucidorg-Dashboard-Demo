// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/components/cat_score_diff_text_heading.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/overview_sb/highLevelScoresRow.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class HighLevelScoresWidget extends ConsumerWidget {
  final bool showHeading;
  const HighLevelScoresWidget({
    this.showHeading = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    return Column(
      children: [
        if (showHeading)
          Column(
            children: [
              Text('High Level Scores', style: kH3PoppinsRegular),
              SizedBox(height: 30),
            ],
          ),
        CategoryScoreDiffTextHeading(),
        SizedBox(height: 4),
        Divider(color: Color(0xFFC7C7C7), thickness: 1),
        SizedBox(height: 12),
        HighLevelScoresRow(
          category: 'Alignment',
          score: displayData.companyBenchmarks[Indicator.align]!,
          diff: displayData.diffScores[Indicator.align]!,
        ),
        SizedBox(height: 12),
        HighLevelScoresRow(
          category: 'People',
          score: displayData.companyBenchmarks[Indicator.people]!,
          diff: displayData.diffScores[Indicator.people]!,
        ),
        SizedBox(height: 12),
        HighLevelScoresRow(
          category: 'Process',
          score: displayData.companyBenchmarks[Indicator.process]!,
          diff: displayData.diffScores[Indicator.process]!,
        ),
        SizedBox(height: 12),
        HighLevelScoresRow(
          category: 'Leadership',
          score: displayData.companyBenchmarks[Indicator.leadership]!,
          diff: displayData.diffScores[Indicator.leadership]!,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
