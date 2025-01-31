// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/impact/impact_body.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/components/impact_area_widget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class OrgImpactSideBar extends StatelessWidget {
  const OrgImpactSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25).copyWith(top: 40),
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            Text('Impact Areas', style: kH2PoppinsLight),
            ImpactAreaWidget(mainArea: MainArea.alignment),
            ImpactAreaWidget(mainArea: MainArea.leadership),
            ImpactAreaWidget(mainArea: MainArea.people),
            ImpactAreaWidget(mainArea: MainArea.process),
          ],
        ),
      ),
    );
  }
}
