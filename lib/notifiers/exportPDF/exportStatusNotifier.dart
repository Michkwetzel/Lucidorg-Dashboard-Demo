import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ExportStatus { idle, exporting, done, error }

// Status of exporting
class ExportState {
  final ExportStatus status;
  final int currentWidgetIndex;
  final int totalWidgets;

  ExportState({
    required this.status,
    required this.currentWidgetIndex,
    required this.totalWidgets,
  });

  ExportState copyWith({
    ExportStatus? status,
    int? currentWidgetIndex,
    int? totalWidgets,
  }) {
    return ExportState(status: status ?? this.status, currentWidgetIndex: currentWidgetIndex ?? this.currentWidgetIndex, totalWidgets: totalWidgets ?? this.totalWidgets);
  }

  factory ExportState.initial() {
    return ExportState(status: ExportStatus.idle, currentWidgetIndex: 0, totalWidgets: 0);
  }
}

class ExportStatusNotifier extends StateNotifier<ExportState> {
  ExportStatusNotifier() : super(ExportState.initial());

  void startExport(int numWidgets) {
    state = state.copyWith(status: ExportStatus.exporting, currentWidgetIndex: 0, totalWidgets: numWidgets);
  }

  void updateProgress(int currentWidgetIndex) {
    state = state.copyWith(currentWidgetIndex: currentWidgetIndex);
  }

  void exportDone() {
    state = state.copyWith(status: ExportStatus.done);
  }
}
