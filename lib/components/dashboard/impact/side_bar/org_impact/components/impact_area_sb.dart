// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/dataClasses/temp/indicator_data_temp.dart';
import 'package:platform_front/dataClasses/temp/impact_area_data.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/components/impact_area_sub_widget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class ImpactAreaSBWidget extends StatelessWidget {
  final MainArea mainArea;
  const ImpactAreaSBWidget({super.key, required this.mainArea});

  @override
  Widget build(BuildContext context) {
    final areaData = ImpactAreaData.mainAreas[mainArea]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(areaData.title, style: kH3PoppinsRegular),
        SizedBox(
          height: 8,
        ),
        for (IndicatorDataTemp impactArea in areaData.impactAreas)
          ImpactAreaSubWidget(
            impactValue: impactArea.impactValue,
            heading: impactArea.heading,
            body: impactArea.body,
          ),
      ],
    );
  }
}
