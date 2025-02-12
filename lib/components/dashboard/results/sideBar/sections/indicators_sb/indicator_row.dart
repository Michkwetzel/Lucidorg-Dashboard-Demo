// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/data_class/all_indicator_data.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/data_class/indicator_data.dart';
import 'package:platform_front/components/global/score_boxes/diff_box.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/selectedIndicator/selected_indicator.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class IndicatorRow extends ConsumerWidget {
  final Indicator indicator;

  const IndicatorRow({
    super.key,
    required this.indicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;
    Map<Indicator, IndicatorData> allIndicatorData = AllIndicatorData.indicatorMap;
    String heading = '';
    double score = 0;
    double diff = 0;

    heading = allIndicatorData[indicator]!.heading;
    score = displayData.companyBenchmarks[indicator.asString]!;
    diff = displayData.diffScores[indicator.asString]!;

    SelectedIndicator selectedIndicator = ref.read(selectedIndicatorProvider.notifier);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('Changed Main display to: $heading');
          selectedIndicator.changeMainDisplay(indicator);
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 130,
                child: Text(heading, style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
              ),
              ScoreBox(height: 40, width: 60, score: score, textSize: 15, fontWeight: FontWeight.w300),
              DiffBox(height: 33, width: 55, diff: diff, textSize: 14, fontWeight: FontWeight.w300)
            ],
          ),
        ),
      ),
    );
  }
}
