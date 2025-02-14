// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/indicators_sb/indicator_sb.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/diif_matrix_sb/diff_matrix_side_bar.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/overview_sb/overview_side_bar.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/foundations_sb.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

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
        case ResultSection.foundations:
          return FoundationsSB();
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 5, bottom: 5),
      width: 350,
      decoration: kboxShadowNormal,
      child: _returnSideBarWidget(),
    );
  }
}
