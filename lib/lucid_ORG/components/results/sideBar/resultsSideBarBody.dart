// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/change_over_time/score_over_time/score_over_time_MV.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/change_over_time/diif_over_time/diff_over_time_sb.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/change_over_time/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/indicators_sb/indicator_sb.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/diif_matrix_sb/diff_matrix_side_bar.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/overview_sb/overview_side_bar.dart';
import 'package:platform_front/lucid_ORG/archive/results/foundations/foundations_sb.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class ResultsSideBar extends ConsumerWidget {
  const ResultsSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResultSection selectedSection = ref.watch(resultsSelectedSectionProvider);

    Widget _returnSideBarWidget() {
      switch (selectedSection) {
        case ResultSection.overview:
          return OverViewSBResults();

        case ResultSection.areaScore:
          return IndicatorSideBar();

        case ResultSection.diffMatrix:
          return DiffMatrixSideBar();

        case ResultSection.diffOverTime:
          return DiffOverTimeSb();

        case ResultSection.scoreOverTime:
          return ScoresOverTimeSB();

        default:
          return Placeholder();
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 5, bottom: 5),
      width: 350,
      decoration: kboxShadowNormal,
      child: BlurOverlay(
        blur: ref.watch(metricsDataProvider).participationBelow30 || ref.watch(metricsDataProvider).needAll3Departments,
        child: _returnSideBarWidget(),
      ),
    );
  }
}
