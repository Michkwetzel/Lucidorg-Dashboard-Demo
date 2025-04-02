import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/components/cat_score_diff_text_heading.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/indicators_sb/indicator_row.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/overview_sb/overallScoresRow.dart';
import 'package:platform_front/global_components/grayDivider.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class IndicatorSideBar extends StatelessWidget {
  const IndicatorSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 40,
        bottom: 20,
      ),
      child: Column(
        children: [
          Text('Indicator Scores', style: kH2PoppinsLight),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: CategoryScoreDiffTextHeading(),
          ),
          Column(
            spacing: 8,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GrayDivider(),
              ),
              IndicatorRow(indicator: Indicator.orgAlign),
              IndicatorRow(indicator: Indicator.growthAlign),
              IndicatorRow(indicator: Indicator.collabKPIs),
              IndicatorRow(indicator: Indicator.engagedCommunity),
              IndicatorRow(indicator: Indicator.crossFuncComms),
              IndicatorRow(indicator: Indicator.crossFuncAcc),
              IndicatorRow(indicator: Indicator.alignedTech),
              IndicatorRow(indicator: Indicator.collabProcesses),
              IndicatorRow(indicator: Indicator.meetingEfficacy),
              IndicatorRow(indicator: Indicator.purposeDriven),
              IndicatorRow(indicator: Indicator.empoweredLeadership),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GrayDivider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: OverallScoresRow(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
