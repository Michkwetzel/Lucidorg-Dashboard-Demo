import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/impact/main_view/buttons/impact_top_button_row.dart';
import 'package:platform_front/lucid_ORG/components/impact/main_view/diff_over_time/diff_over_time_mv.dart';
import 'package:platform_front/lucid_ORG/components/impact/main_view/financial/financial_mv.dart';
import 'package:platform_front/lucid_ORG/components/impact/main_view/org_impact/org_impact_main_view.dart';
import 'package:platform_front/lucid_ORG/components/impact/main_view/score_over_time/score_over_time_MV.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class ImpactMainView extends ConsumerWidget {
  const ImpactMainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImpactSection selectedSection = ref.watch(impactSelectedSectionProvider);

    Widget returnMainViewWidget() {
      switch (selectedSection) {
        case ImpactSection.orgImpact:
          return OrgImpactMainView();

        case ImpactSection.financial:
          return FinancialMv();

        case ImpactSection.diffOverTime:
          return DiffOverTimeMv();

        case ImpactSection.scoreOverTime:
          return ScoreOverTimeMV();
      }
    }

    return Container(
      width: selectedSection == ImpactSection.orgImpact ? 950 : 800,
      padding: EdgeInsets.all(32),
      margin: EdgeInsets.only(left: 5, bottom: 5, right: 5),
      decoration: kboxShadowNormal,
      child: Column(
        children: [
          ImpactTopButtonRow(),
          SizedBox(
            height: 32,
          ),
          BlurOverlay(
            blur: ref.watch(metricsDataProvider).participationBelow30 || ref.watch(metricsDataProvider).needAll3Departments,
            child: returnMainViewWidget(),
          ),
        ],
      ),
    );
  }
}
