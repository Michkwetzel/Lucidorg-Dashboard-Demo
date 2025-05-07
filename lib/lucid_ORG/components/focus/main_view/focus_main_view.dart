import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/focus/main_view/buttons/impact_top_button_row.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/change_over_time/diff_over_time/diff_over_time_mv.dart';
import 'package:platform_front/lucid_ORG/archive/impact/finance/financial/financial_mv.dart';
import 'package:platform_front/lucid_ORG/archive/impact/org_impact/org_impact/org_impact_main_view.dart';
import 'package:platform_front/lucid_ORG/components/focus/main_view/action_step_1/action_step_1_body.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/change_over_time/score_over_time/score_over_time_MV.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class FocusMainView extends StatelessWidget {
  const FocusMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1520,
      padding: EdgeInsets.all(32),
      margin: EdgeInsets.only(left: 5, bottom: 5, right: 5),
      decoration: kboxShadowNormal,
      child: Column(
        children: [
          ImpactActionBar(),
          ImpactContentWidget(),
        ],
      ),
    );
  }
}

class ImpactContentWidget extends ConsumerWidget {
  const ImpactContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImpactSection selectedSection = ref.watch(impactSelectedSectionProvider);

    Widget returnMainViewWidget() {
      switch (selectedSection) {
        case ImpactSection.diffPyramid:
          return ActionStep1Body();

        case ImpactSection.scorePyramid:
          return OrgImpactMainView();

      }
    }

    return BlurOverlay(
      blur: ref.watch(metricsDataProvider).participationBelow30 || ref.watch(metricsDataProvider).needAll3Departments,
      child: returnMainViewWidget(),
    );
  }
}
