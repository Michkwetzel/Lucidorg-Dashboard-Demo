import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/global_org/score_boxes/diff_box.dart';
import 'package:platform_front/lucid_ORG/components/global_org/score_boxes/score_box.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row1/home_pilars.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/data_classes/all_indicator_data.dart';
import 'package:platform_front/lucid_ORG/data_classes/indicator_data.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class HomeIndicators extends StatelessWidget {
  const HomeIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 25,
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
            NonClickIndicatorRow(indicator: Indicator.orgAlign),
            NonClickIndicatorRow(indicator: Indicator.growthAlign),
            NonClickIndicatorRow(indicator: Indicator.collabKPIs),
            NonClickIndicatorRow(indicator: Indicator.engagedCommunity),
            NonClickIndicatorRow(indicator: Indicator.crossFuncComms),
            NonClickIndicatorRow(indicator: Indicator.crossFuncAcc),
            NonClickIndicatorRow(indicator: Indicator.alignedTech),
            NonClickIndicatorRow(indicator: Indicator.collabProcesses),
            NonClickIndicatorRow(indicator: Indicator.meetingEfficacy),
            NonClickIndicatorRow(indicator: Indicator.purposeDriven),
            NonClickIndicatorRow(indicator: Indicator.empoweredLeadership),
          ],
        ),
      ],
    );
  }
}

class NonClickIndicatorRow extends ConsumerWidget {
  final Indicator indicator;

  const NonClickIndicatorRow({
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
    score = displayData.companyBenchmarks[indicator]!;
    diff = displayData.diffScores[indicator]!;

    double companyIndex = displayData.companyBenchmarks[Indicator.companyIndex]!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 130,
            child: Text(heading, style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          ),
          ScoreBox(
            height: 40,
            width: 60,
            score: score,
            textSize: 15,
            fontWeight: FontWeight.w300,
            companyIndex: companyIndex,
          ),
          DiffBox(height: 40, width: 60, diff: diff, textSize: 14, fontWeight: FontWeight.w300)
        ],
      ),
    );
  }
}
