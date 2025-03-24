import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/over_view/overview_main_body.dart';
import 'package:platform_front/notifiers/exportPDF/exportStatusNotifier.dart';

class WidgetConfig {
  final String id;
  final String title;
  final Widget Function() widgetBuilder;

  WidgetConfig({
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
    return ExportsWidgetState(
      widgets: [
        WidgetConfig(
          id: "results_overview_main",
          title: "Results Overview",
          widgetBuilder: () => OverviewMainView(),
        ),
      ],
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
