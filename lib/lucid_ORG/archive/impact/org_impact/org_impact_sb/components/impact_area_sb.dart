// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/data_classes/all_indicator_data.dart';
import 'package:platform_front/lucid_ORG/data_classes/indicator_data.dart';
import 'package:platform_front/lucid_ORG/archive/impact/org_impact/org_impact_sb/components/impact_area_sub_widget.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class ImpactAreaSBWidget extends StatelessWidget {
  final Pilar pilar;
  final List<Indicator> allIndicatorsToShow;
  const ImpactAreaSBWidget({super.key, required this.pilar, required this.allIndicatorsToShow});

  @override
  Widget build(BuildContext context) {
    Map<Indicator, IndicatorData> indicatorMap = AllIndicatorData.indicatorMap;
    List<Indicator> toShow = [];

    for (Indicator indicator in allIndicatorsToShow) {
      if (indicator.pilar == pilar) {
        toShow.add(indicator);
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(pilar.heading, style: kH3PoppinsRegular),
        SizedBox(
          height: 8,
        ),
        for (var indicator in toShow)
          ImpactAreaSubWidget(
            impactValue: indicatorMap[indicator]!.impactNum,
            heading: indicator.heading,
            body: indicatorMap[indicator]!.impactText,
            indicator: indicator,
          ),
      ],
    );
  }
}
