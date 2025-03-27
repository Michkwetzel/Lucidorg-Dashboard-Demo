import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/export/indicator_export/indicators_mv_export.dart';
import 'package:platform_front/components/dashboard/impact/main_view/diff_over_time/diff_over_time_mv.dart';
import 'package:platform_front/components/dashboard/impact/main_view/org_impact/org_impact_main_view.dart';
import 'package:platform_front/components/dashboard/impact/main_view/score_over_time/score_over_time_MV.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/diif_over_time/diff_over_time_sb.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/org_impact_SB.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/diff_matrix/diff_matrix_body.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/foundations/foundations_body.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/over_view/overview_main_body.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/exportPDF/exportStatusNotifier.dart';

class WidgetConfig {
  final String id;
  final String title;
  final bool big;
  final Widget Function() widgetBuilder;

  WidgetConfig({
    this.big = false,
    required this.id,
    required this.title,
    required this.widgetBuilder,
  });

  factory WidgetConfig.empty() {
    return WidgetConfig(id: "", title: "", widgetBuilder: () => Container());
  }
}

// Contains the widgets to be exported
class ExportsWidgetState {
  final List<WidgetConfig> widgets;
  final int index;
  final WidgetConfig currentExportWidget;

  ExportsWidgetState({required this.widgets, required this.index, required this.currentExportWidget});

  ExportsWidgetState copyWith({List<WidgetConfig>? widgets, int? index, WidgetConfig? currentExportWidget}) {
    return ExportsWidgetState(widgets: widgets ?? this.widgets, index: index ?? this.index, currentExportWidget: currentExportWidget ?? this.currentExportWidget);
  }

  factory ExportsWidgetState.initial() {
    // Create initial list
    final List<WidgetConfig> widgetsList = [
      WidgetConfig(
        id: "results_overview_main",
        title: "Results Overview",
        widgetBuilder: () => OverviewMainView(),
      ),
      WidgetConfig(
        id: "foundations_main",
        title: "Foundations",
        widgetBuilder: () => FoundationsBody(),
      ),
      WidgetConfig(
        id: "diff_matrix",
        title: "Differentiation Matrix",
        widgetBuilder: () => DiffMatrixBody(),
      ),
      WidgetConfig(
        id: "impact_main",
        title: "Organizational Impact",
        big: true,
        widgetBuilder: () => Row(
          spacing: 32,
          children: [
            Container(margin: EdgeInsets.only(left: 5, bottom: 5), width: 350, decoration: kboxShadowNormal, child: OrgImpactSB()),
            OrgImpactMainView(),
          ],
        ),
      ),
      WidgetConfig(
        id: "score_over_time",
        title: "Score over time",
        big: true,
        widgetBuilder: () => Row(
          spacing: 32,
          children: [
            Container(margin: EdgeInsets.only(left: 5, bottom: 5), width: 350, decoration: kboxShadowNormal, child: ScoresOverTimeSB()),
            SizedBox(
                width: 750,
                child: Row(
                  children: [
                    Expanded(child: ScoreOverTimeMV()),
                  ],
                )),
          ],
        ),
      ),
      WidgetConfig(
        id: "diff_over_time",
        title: "Differentiation over time",
        big: true,
        widgetBuilder: () => Row(
          spacing: 32,
          children: [
            Container(margin: EdgeInsets.only(left: 5, bottom: 5), width: 350, decoration: kboxShadowNormal, child: DiffOverTimeSb()),
            ClipRect(
              child: SizedBox(
                  width: 750,
                  child: Row(
                    children: [
                      Expanded(child: DiffOverTimeMv()),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ];

    // Add the indicator widgets to the list
    final indicators = justIndicators();
    for (final indicator in indicators) {
      widgetsList.add(
        WidgetConfig(
          id: "indicator_${indicator.heading}",
          title: indicator.heading,
          widgetBuilder: () => IndicatorsMainViewExport(indicator: indicator),
        ),
      );
    }

    return ExportsWidgetState(
      widgets: widgetsList,
      index: 0,
      currentExportWidget: WidgetConfig.empty(),
    );
  }
}

class ExportsWidgetNotifier extends StateNotifier<ExportsWidgetState> {
  final ExportStatusNotifier exportStatusNotifier;

  ExportsWidgetNotifier({required this.exportStatusNotifier}) : super(ExportsWidgetState.initial());

  void nextWidget() {
    int newIndex = state.index + 1;

    if (state.index < state.widgets.length) {
      state = state.copyWith(index: newIndex, currentExportWidget: state.widgets[newIndex]);
    }
  }

  void setCurrentWidget(int index) {
    state = state.copyWith(currentExportWidget: state.widgets[index]);
  }
}
