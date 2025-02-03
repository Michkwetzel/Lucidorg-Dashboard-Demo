// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/impact/impact_body.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/diif_over_time/diff_over_time_sb.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/financial/financial_SB.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/org_impact_SB.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class ImpactSideBar extends ConsumerWidget {
  const ImpactSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImpactSection selectedSection = ref.watch(impactSelectedSectionProvider);

    Widget returnSideBarWidget() {
      switch (selectedSection) {
        case ImpactSection.orgImpact:
          return OrgImpactSideBar();
        case ImpactSection.financial:
          return FinancialSB();
        case ImpactSection.scoreOverTime:
          return ScoresOverTimeSB();
        case ImpactSection.diffOverTime:
          return DiffOverTimeSb();
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 5, bottom: 5),
      width: 350,
      decoration: kboxShadowNormal,
      child: returnSideBarWidget(),
    );
  }
}
