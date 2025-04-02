// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/overview_sb/high_level_scores_widget.dart';
import 'package:platform_front/lucid_ORG/components/global_org/diffTriangleRedWidget.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class OverViewSBResults extends StatelessWidget {
  const OverViewSBResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OverallScoreAndDiffWidget(),
          SizedBox(height: 60),
          HighLevelScoresWidget(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class OverallScoreAndDiffWidget extends ConsumerWidget {
  const OverallScoreAndDiffWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    double overallScore = displayData.companyBenchmarks[Indicator.companyIndex]!;
    double overallDiff = displayData.diffScores[Indicator.companyIndex]!;

    return Column(
      children: [
        Text("Benchmark Score", style: kH2PoppinsLight),
        SizedBox(height: 8),
        Text('$overallScore%', style: kH2TotalScoreLight),
        SizedBox(height: 60),
        Text(
          'Benchmark Differentiation',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 22),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        DiffTriangleRedWidget(value: overallDiff, size: Diffsize.H2),
      ],
    );
  }
}
