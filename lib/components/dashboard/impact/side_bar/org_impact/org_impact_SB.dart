// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/impact/impact_body.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/components/impact_area_sb.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class OrgImpactSB extends StatelessWidget {
  const OrgImpactSB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25).copyWith(top: 40),
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            Text('Impact Areas', style: kH2PoppinsLight),
            ImpactAreaSBWidget(mainArea: MainArea.alignment),
            ImpactAreaSBWidget(mainArea: MainArea.people),
            ImpactAreaSBWidget(mainArea: MainArea.process),
            ImpactAreaSBWidget(mainArea: MainArea.leadership),
          ],
        ),
      ),
    );
  }
}
