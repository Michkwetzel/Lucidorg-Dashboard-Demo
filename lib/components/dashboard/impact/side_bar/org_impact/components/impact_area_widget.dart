// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/data_class/impact_area.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/data_class/impact_area_data.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/components/impact_area_sub_widget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class ImpactAreaWidget extends StatelessWidget {
  final MainArea mainArea;
  const ImpactAreaWidget({super.key, required this.mainArea});

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
        for (ImpactArea impactArea in areaData.impactAreas)
          ImpactAreaSubWidget(
            impactValue: impactArea.impactValue,
            heading: impactArea.heading,
            body: impactArea.body,
          ),
      ],
    );
  }
}
