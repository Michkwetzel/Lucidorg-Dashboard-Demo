// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/change_over_time/diif_over_time/diff_over_time_sb.dart';
import 'package:platform_front/lucid_ORG/archive/impact/finance/financial_sb/financial_SB.dart';
import 'package:platform_front/lucid_ORG/archive/impact/org_impact/org_impact_sb/org_impact_SB.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/change_over_time/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class ImpactSideBar extends ConsumerWidget {
  const ImpactSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImpactSection selectedSection = ref.watch(impactSelectedSectionProvider);

    Widget returnSideBarWidget() {
      switch (selectedSection) {
        case ImpactSection.diffPyramid:
          return OrgImpactSB();
        case ImpactSection.scorePyramid:
          return OrgImpactSB();
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 5, bottom: 5),
      width: 350,
      decoration: kboxShadowNormal,
      child: BlurOverlay(
        blur: ref.watch(metricsDataProvider).participationBelow30 || ref.watch(metricsDataProvider).needAll3Departments,
        child: returnSideBarWidget(),
      ),
    );
  }
}
