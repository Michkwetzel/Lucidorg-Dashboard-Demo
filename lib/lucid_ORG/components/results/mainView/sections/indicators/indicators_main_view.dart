import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/dataClasses/all_indicator_data.dart';
import 'package:platform_front/lucid_ORG/dataClasses/indicator_data.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/indicators/indicator_score_box.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/indicators/indicator_diff_box.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/indicators/department_scores_widget.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/indicators/indicator_text_widget.dart';
import 'package:platform_front/global_components/grayDivider.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class IndicatorsMainView extends StatelessWidget {
  const IndicatorsMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IndicatorTextWidget(),
          ),
        ),
        SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: GrayDivider(),
        ),
        SizedBox(height: 40),
        IndicatorsDepartmentScoresWidget(),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 80,
          children: [
            IndicatorScoreBox(text: 'Overall Score'),
            IndicatorDiffBox(text: 'Differentiation', diff: 38),
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
            IndicatorScoreBrief(),
            IndicatorDiffBrief(),
          ],
        ),
      ],
    );
  }
}

class IndicatorDiffBrief extends ConsumerWidget {
  const IndicatorDiffBrief({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = ref.watch(selectedIndicatorProvider);
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
  const IndicatorScoreBrief({
    super.key,
  });

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = ref.watch(selectedIndicatorProvider);
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
