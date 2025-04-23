import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/global_org/diffTriangleRedWidget.dart';
import 'package:platform_front/lucid_ORG/data_classes/all_indicator_data.dart';
import 'package:platform_front/lucid_ORG/data_classes/indicator_data.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/indicators/department_scores_widget.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class IndicatorsMainViewExport extends StatelessWidget {
  final Indicator indicator;
  const IndicatorsMainViewExport({super.key, required this.indicator});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IndicatorTextWidget(indicator: indicator),
          ),
        ),
        SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: CustomDivider(),
        ),
        SizedBox(height: 40),
        IndicatorsDepartmentScoresWidget(indicator: indicator),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 80,
          children: [
            IndicatorScoreBox(text: 'Overall Score', indicator: indicator),
            IndicatorDiffBox(text: 'Differentiation', diff: 38, indicator: indicator),
          ],
        ),
        SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 32),
            Expanded(child: Text('Score Analysis', style: kH4PoppinsLight)),
            Expanded(child: Text('Differentiation Analysis', style: kH4PoppinsLight)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 32),
            IndicatorScoreBrief(indicator: indicator),
            IndicatorDiffBrief(indicator: indicator),
          ],
        ),
      ],
    );
  }
}

class IndicatorTextWidget extends ConsumerWidget {
  final Indicator indicator;
  const IndicatorTextWidget({super.key, required this.indicator});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      indicator.heading,
      style: kH3PoppinsMedium,
    );
  }
}

class IndicatorDiffBrief extends ConsumerWidget {
  final Indicator indicator;
  const IndicatorDiffBrief({
    required this.indicator,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = indicator;
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;
    double diff = displayData.diffScores[selectedIndicator]!;

    Map<Indicator, IndicatorData> allIndicatorData = AllIndicatorData.indicatorMap;

    String diffTextBody = allIndicatorData[selectedIndicator]!.getScoreTextBody(diff).replaceAll("___", '${diff.toString()}%');

    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(right: 40),
        child: Column(
          children: [
            Text(
              diffTextBody,
              style: kH6PoppinsLight,
            ),
          ],
        ),
      ),
    );
  }
}

class IndicatorScoreBrief extends ConsumerWidget {
  final Indicator indicator;

  const IndicatorScoreBrief({
    required this.indicator,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = indicator;
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;
    double score = displayData.companyBenchmarks[selectedIndicator]!;

    Map<Indicator, IndicatorData> allIndicatorData = AllIndicatorData.indicatorMap;

    String scoreTextBody = allIndicatorData[selectedIndicator]!.getScoreTextBody(score).replaceAll("___", '${score.toString()}%');

    String scoreTextHeading = allIndicatorData[selectedIndicator]!.getScoreTextHeading(score);

    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(right: 40),
        child: Column(
          children: [
            Text(
              scoreTextHeading,
              style: kH6PoppinsRegular,
            ),
            Text(
              scoreTextBody,
              style: kH6PoppinsLight,
            ),
          ],
        ),
      ),
    );
  }
}

class IndicatorsDepartmentScoresWidget extends ConsumerWidget {
  final Indicator indicator;

  const IndicatorsDepartmentScoresWidget({super.key, required this.indicator});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    Indicator selectedIndicator = indicator;
    double ceoScore = displayData.ceoBenchmarks[selectedIndicator]!;
    double cSuiteScore = displayData.cSuiteBenchmarks[selectedIndicator]!;
    double employeeScore = displayData.employeeBenchmarks[selectedIndicator]!;

    return PerDepertmentScoresWidget(
      ceoScore: ceoScore,
      cSuiteScore: cSuiteScore,
      employeeScore: employeeScore,
      bold: true,
    );
  }
}

class IndicatorScoreBox extends ConsumerWidget {
  final String text;
  final Indicator indicator;

  const IndicatorScoreBox({super.key, required this.text, required this.indicator});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = indicator;
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

class IndicatorDiffBox extends ConsumerWidget {
  final String text;
  final double diff;
  final Indicator indicator;

  const IndicatorDiffBox({super.key, required this.text, required this.diff, required this.indicator});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = indicator;
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
