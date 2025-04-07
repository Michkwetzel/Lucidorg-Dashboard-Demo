import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/components/resultsTopButtonRow.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/indicators/indicators_main_view.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/diff_matrix/diff_matrix_body.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/over_view/overview_main_body.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/foundations/foundations_body.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/global_components/loading_overlay.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class MainViewBody extends ConsumerWidget {
  const MainViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResultSection selectedSection = ref.watch(resultsSelectedSectionProvider);

    Widget _returnMainViewWidget() {
      switch (selectedSection) {
        case ResultSection.overview:
          return OverviewMainView();

        case ResultSection.areaScore:
          return IndicatorsMainView();

        case ResultSection.diffMatrix:
          return DiffMatrixBody();

        case ResultSection.foundations:
          return FoundationsBody();
      }
    }

    return Container(
      width: selectedSection == ResultSection.diffMatrix ? 900 : 800,
      padding: EdgeInsets.all(32),
      margin: EdgeInsets.only(left: 5, bottom: 5, right: 5),
      decoration: kboxShadowNormal,
      child: Column(
        children: [
          ResultsTopButtonRow(),
          SizedBox(
            height: 32,
          ),
          BlurOverlay(
            blur: ref.watch(metricsDataProvider).participationBelow30 || ref.watch(metricsDataProvider).needAll3Departments,
            child: _returnMainViewWidget(),
          ),
        ],
      ),
    );
  }
}
