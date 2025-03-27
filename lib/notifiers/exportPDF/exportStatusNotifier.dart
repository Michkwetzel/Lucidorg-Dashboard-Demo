import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ExportPhase { idle, capturingWidgets, generatingPdf, savingPdf, complete, error }

class ExportStatus {
  final int currentWidgetIndex;
  final int totalWidgets;
  final ExportPhase phase;
  final String? errorMessage;
  final double phaseProgress; // 0.0 to 1.0 to show progress within a phase

  const ExportStatus({
    required this.currentWidgetIndex,
    required this.totalWidgets,
    required this.phase,
    this.errorMessage,
    this.phaseProgress = 0.0,
  });

  ExportStatus copyWith({
    int? currentWidgetIndex,
    int? totalWidgets,
    ExportPhase? phase,
    String? errorMessage,
    double? phaseProgress,
  }) {
    return ExportStatus(
      currentWidgetIndex: currentWidgetIndex ?? this.currentWidgetIndex,
      totalWidgets: totalWidgets ?? this.totalWidgets,
      phase: phase ?? this.phase,
      errorMessage: errorMessage ?? this.errorMessage,
      phaseProgress: phaseProgress ?? this.phaseProgress,
    );
  }

  // Calculate the overall progress (0.0 to 1.0) based on phase and widget progress
  double get overallProgress {
    switch (phase) {
      case ExportPhase.idle:
        return 0.0;
      case ExportPhase.capturingWidgets:
        // Capturing widgets accounts for 50% of the process
        return (currentWidgetIndex / totalWidgets) * 0.5;
      case ExportPhase.generatingPdf:
        // Generating PDF accounts for 20% of the process
        return 0.5 + (phaseProgress * 0.2);
      case ExportPhase.savingPdf:
        // Saving PDF accounts for the final 30% (increased to give more time representation)
        return 0.7 + (phaseProgress * 0.3);
      case ExportPhase.complete:
        return 1.0;
      case ExportPhase.error:
        // If error, show progress up to where the error occurred
        return currentWidgetIndex / totalWidgets;
    }
  }

  // Get a user-friendly message based on the current export phase
  String get statusMessage {
    switch (phase) {
      case ExportPhase.idle:
        return "Ready to export";
      case ExportPhase.capturingWidgets:
        return "Capturing widget ${currentWidgetIndex + 1} of $totalWidgets";
      case ExportPhase.generatingPdf:
        return "Generating PDF document";
      case ExportPhase.savingPdf:
        return "Saving PDF (this may take several minutes)";
      case ExportPhase.complete:
        return "Export complete!";
      case ExportPhase.error:
        return "Error: ${errorMessage ?? 'Unknown error'}";
    }
  }

  // For determining the color of the progress indicator
  Color get statusColor {
    switch (phase) {
      case ExportPhase.idle:
        return Colors.blue;
      case ExportPhase.capturingWidgets:
      case ExportPhase.generatingPdf:
      case ExportPhase.savingPdf:
        return Colors.orange;
      case ExportPhase.complete:
        return Colors.green;
      case ExportPhase.error:
        return Colors.red;
    }
  }
}

class ExportStatusNotifier extends StateNotifier<ExportStatus> {
  ExportStatusNotifier()
      : super(const ExportStatus(
          currentWidgetIndex: 0,
          totalWidgets: 0,
          phase: ExportPhase.idle,
        ));

  void startExport(int totalWidgets) {
    state = ExportStatus(
      currentWidgetIndex: 0,
      totalWidgets: totalWidgets,
      phase: ExportPhase.capturingWidgets,
    );
  }

  void updateProgress(int index) {
    state = state.copyWith(
      currentWidgetIndex: index,
      phase: ExportPhase.capturingWidgets,
    );
  }

  void setPhase(ExportPhase phase, {double progress = 0.0}) {
    state = state.copyWith(
      phase: phase,
      phaseProgress: progress,
    );
  }

  void updatePhaseProgress(double progress) {
    state = state.copyWith(
      phaseProgress: progress,
    );
  }

  void exportDone() {
    state = state.copyWith(
      phase: ExportPhase.complete,
      phaseProgress: 1.0,
    );
  }

  void exportError(String errorMessage) {
    state = state.copyWith(
      phase: ExportPhase.error,
      errorMessage: errorMessage,
    );
  }

  void reset() {
    state = const ExportStatus(
      currentWidgetIndex: 0,
      totalWidgets: 0,
      phase: ExportPhase.idle,
    );
  }
}
