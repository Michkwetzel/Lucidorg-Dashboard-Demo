import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/archive/results/foundations/foundations_mv.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/data_classes/all_indicator_data.dart';
import 'package:platform_front/lucid_ORG/data_classes/indicator_data.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class FoundationsSB extends StatelessWidget {
  const FoundationsSB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 8,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Foundations", style: kH2PoppinsRegular),
                  SizedBox(width: 8), // Add some spacing between text and icon
                  Tooltip(
                    decoration: kboxShadowNormal,
                    textStyle: TextStyle(color: Colors.black),
                    message:
                        "Most assessments focus solely on productivity (operations) or engagement (workforce) in isolation,\nbut true organizational efficiency emerges when both are measured together",
                    child: Icon(
                      Icons.info_outline,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              CustomDivider(
                width: 250,
              ),
            ],
          ),
          FoundationsSBWidget(
            indicator: Indicator.operations,
          ),
          CustomDivider(
            width: 230,
          ),
          FoundationsSBWidget(
            indicator: Indicator.workforce,
          ),
        ],
      ),
    );
  }
}

class FoundationsSBWidget extends ConsumerWidget {
  final Indicator indicator;
  const FoundationsSBWidget({super.key, required this.indicator});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Indicator, IndicatorData> allIndicatorData = AllIndicatorData.indicatorMap;
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;
    double score = displayData.companyBenchmarks[indicator]!;

    String scoreTextBody = allIndicatorData[indicator]!.getScoreTextBody(score).replaceAll("___", '${score.toString()}%');

    double minValue1 = double.infinity;
    Indicator minIndicator1 = Indicator.operations;
    double minValue2 = double.infinity;
    Indicator minIndicator2 = Indicator.operations;

    if (indicator == Indicator.workforce) {
      List<Map<Indicator, double>> people = displayData.getSpecificFoundations([Indicator.engagedCommunity, Indicator.crossFuncComms, Indicator.crossFuncAcc]);
      for (var map in people) {
        map.forEach((indicator, value) {
          if (value < minValue1) {
            minValue1 = value;
            minIndicator1 = indicator;
          }
        });
      }
      List<Map<Indicator, double>> leadership = displayData.getSpecificFoundations([Indicator.empoweredLeadership, Indicator.purposeDriven]);
      for (var map in leadership) {
        map.forEach((indicator, value) {
          if (value < minValue2) {
            minValue2 = value;
            minIndicator2 = indicator;
          }
        });
      }
    } else {
      List<Map<Indicator, double>> allignment = displayData.getSpecificFoundations([Indicator.growthAlign, Indicator.collabKPIs, Indicator.orgAlign]);
      for (var map in allignment) {
        map.forEach((indicator, value) {
          if (value < minValue1) {
            minValue1 = value;
            minIndicator1 = indicator;
          }
        });
      }
      List<Map<Indicator, double>> process = displayData.getSpecificFoundations([Indicator.alignedTech, Indicator.collabProcesses, Indicator.meetingEfficacy]);
      for (var map in process) {
        map.forEach((indicator, value) {
          if (value < minValue2) {
            minValue2 = value;
            minIndicator2 = indicator;
          }
        });
      }
    }

    return Column(
      spacing: 16,
      children: [
        Text(indicator.heading, style: kH2PoppinsLight),
        Text(
          scoreTextBody,
          style: kH7PoppinsLight,
          textAlign: TextAlign.center,
        ),
        Text("Suggested Focus Areas", style: kH4PoppinsLight),
        SizedBox(width: 230, child: FoundationsRow(indicator: minIndicator1)),
        SizedBox(width: 230, child: FoundationsRow(indicator: minIndicator2)),
      ],
    );
  }
}
