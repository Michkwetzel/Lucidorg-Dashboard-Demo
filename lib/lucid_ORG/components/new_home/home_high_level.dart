import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/global_org/diffTriangleRedWidget.dart';
import 'package:platform_front/lucid_ORG/components/home/charts/pieChartWidget.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/indicators/department_scores_widget.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/overview_sb/highLevelScoresRow.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/overview_sb/high_level_scores_widget.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class HomeHighLevelOverView extends ConsumerWidget {
  const HomeHighLevelOverView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: kboxShadowNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHighLevelScoresWidget(
            showHeading: false,
          ),
        ],
      ),
    );
  }
}

class TotalScores extends ConsumerWidget {
  const TotalScores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    double companyIndex = displayData.companyBenchmarks[Indicator.companyIndex] ?? 50;
    double indexDiff = displayData.diffScores[Indicator.companyIndex] ?? 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 135,
          width: 250,
          padding: const EdgeInsets.all(24),
          decoration: kboxShadowNormal,
          child: Column(
            children: [
              Text('Total Score', style: kH2PoppinsLight),
              SizedBox(height: 8),
              Text('${companyIndex.toStringAsFixed(1)}%', style: kH1TotalScoreRegular),
            ],
          ),
        ),
        Container(
          height: 135,
          width: 250,
          padding: const EdgeInsets.all(24),
          decoration: kboxShadowNormal,
          child: Column(
            children: [
              Text('Differentiation', style: kH3PoppinsLight),
              SizedBox(height: 8),
              DiffTriangleRedWidget(
                size: Diffsize.H1,
                value: indexDiff,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class HomeHighLevelScoresWidget extends ConsumerWidget {
  final bool showHeading;
  const HomeHighLevelScoresWidget({
    this.showHeading = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    return Column(
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 50,
          children: [
            SizedBox(
              width: 60,
              child: Center(child: Text('Score', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14))),
            ),
            SizedBox(
              width: 60,
              child: Center(
                child: Text('Diff', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14)),
              ),
            ),
          ],
        ),
        Column(
          spacing: 20,
          children: [
            HighLevelScoresRow(
              category: 'Alignment',
              score: displayData.companyBenchmarks[Indicator.align]!,
              diff: displayData.diffScores[Indicator.align]!,
            ),
            HighLevelScoresRow(
              category: 'People',
              score: displayData.companyBenchmarks[Indicator.people]!,
              diff: displayData.diffScores[Indicator.people]!,
            ),
            HighLevelScoresRow(
              category: 'Process',
              score: displayData.companyBenchmarks[Indicator.process]!,
              diff: displayData.diffScores[Indicator.process]!,
            ),
            HighLevelScoresRow(
              category: 'Leadership',
              score: displayData.companyBenchmarks[Indicator.leadership]!,
              diff: displayData.diffScores[Indicator.leadership]!,
            ),
          ],
        ),
      ],
    );
  }
}
