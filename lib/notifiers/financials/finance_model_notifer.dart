import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/surveyMetrics/survey_metrics_provider.dart';

class FinanceModelState {
  final double profitIncrease;
  final double costDecrease;
  final double marginIncrease;
  final double employeProductivityIncrease;
  final int timeFrame;
  final Map<Indicator, double> futureIndicators;

  final double align1;
  final double people1;
  final double process1;
  final double leadership1;

  FinanceModelState({
    required this.profitIncrease,
    required this.costDecrease,
    required this.marginIncrease,
    required this.employeProductivityIncrease,
    required this.timeFrame,
    required this.futureIndicators,
    required this.align1,
    required this.people1,
    required this.process1,
    required this.leadership1,
  });

  factory FinanceModelState.initial() {
    return FinanceModelState(
      profitIncrease: 0.0,
      costDecrease: 0.0,
      marginIncrease: 0.0,
      employeProductivityIncrease: 0.0,
      timeFrame: 0,
      futureIndicators: {
        Indicator.orgAlign: 0,
        Indicator.growthAlign: 0,
        Indicator.collabKPIs: 0,
        Indicator.engagedCommunity: 0,
        Indicator.crossFuncComms: 0,
        Indicator.crossFuncAcc: 0,
        Indicator.alignedTech: 0,
        Indicator.collabProcesses: 0,
        Indicator.meetingEfficacy: 0,
        Indicator.purposeDriven: 0,
        Indicator.empoweredLeadership: 0,
      },
      align1: 0.0,
      people1: 0.0,
      process1: 0.0,
      leadership1: 0.0,
    );
  }

  FinanceModelState copyWith({
    double? profitIncrease,
    double? costDecrease,
    double? marginIncrease,
    double? employeProductivityIncrease,
    int? timeFrame,
    Map<Indicator, double>? futureIndicators,
    double? align1,
    double? people1,
    double? process1,
    double? leadership1,
  }) {
    return FinanceModelState(
      profitIncrease: profitIncrease ?? this.profitIncrease,
      costDecrease: costDecrease ?? this.costDecrease,
      marginIncrease: marginIncrease ?? this.marginIncrease,
      employeProductivityIncrease: employeProductivityIncrease ?? this.employeProductivityIncrease,
      timeFrame: timeFrame ?? this.timeFrame,
      futureIndicators: futureIndicators ?? this.futureIndicators,
      align1: align1 ?? this.align1,
      people1: people1 ?? this.people1,
      process1: process1 ?? this.process1,
      leadership1: leadership1 ?? this.leadership1,
    );
  }
}

class FinanceModelNotifer extends StateNotifier<FinanceModelState> {
  final MetricsDataProvider metricsDataProvider; //For my current survey Data

  FinanceModelNotifer({required this.metricsDataProvider}) : super(FinanceModelState.initial());

  void sliderChange(Indicator indicator, double increase) {
    state.futureIndicators[indicator] = metricsDataProvider.getCurrentSurveyMetric().companyBenchmarks[indicator]! * increase;
  }

  void calculateInitialValues() {
    Map<Indicator, double> currentIndicators = metricsDataProvider.getCurrentSurveyMetric().companyBenchmarks;

    double align2 = currentIndicators[Indicator.growthAlign]! * 0.3 + currentIndicators[Indicator.collabKPIs]! * 0.5 + currentIndicators[Indicator.orgAlign]! * 0.2;
    double people2 = currentIndicators[Indicator.engagedCommunity]! * 0.4 + currentIndicators[Indicator.crossFuncComms]! * 0.3 + currentIndicators[Indicator.crossFuncAcc]! * 0.3;
    double process2 = currentIndicators[Indicator.meetingEfficacy]! * 0.2 + currentIndicators[Indicator.alignedTech]! * 0.4 + currentIndicators[Indicator.collabProcesses]! * 0.4;
    double leadership2 = currentIndicators[Indicator.purposeDriven]! * 0.4 + currentIndicators[Indicator.empoweredLeadership]! * 0.6;

    double align1 = (currentIndicators[Indicator.align]! - align2 * 0.65) / 0.35;
    double people1 = (currentIndicators[Indicator.people]! - people2 * 0.65) / 0.35;
    double process1 = (currentIndicators[Indicator.process]! - process2 * 0.65) / 0.35;
    double leadership1 = (currentIndicators[Indicator.leadership]! - leadership2 * 0.65) / 0.35;

    Map<Indicator, double> increaseIndicators = {};

    for (var indicator in state.futureIndicators.keys) {
      double newVavlue = currentIndicators[indicator]! * 1.2;
      increaseIndicators[indicator] = newVavlue > 80 ? 80 : newVavlue; //Cap value of indicator at 80%
    }

    state = state.copyWith(align1: align1, people1: people1, process1: process1, leadership1: leadership1, futureIndicators: increaseIndicators);
  }

  void setTimeFrame(int timeFrame) {
    state = state.copyWith(timeFrame: timeFrame);
  }

  void calculateFinanceValues() {
    Map<Indicator, double> currentIndicators = metricsDataProvider.getCurrentSurveyMetric().companyBenchmarks;

    // Now calculate new Efficiency score
    double align2 = state.futureIndicators[Indicator.growthAlign]! * 0.3 + state.futureIndicators[Indicator.collabKPIs]! * 0.5 + state.futureIndicators[Indicator.orgAlign]! * 0.2;
    double people2 = state.futureIndicators[Indicator.engagedCommunity]! * 0.4 + state.futureIndicators[Indicator.crossFuncComms]! * 0.3 + state.futureIndicators[Indicator.crossFuncAcc]! * 0.3;
    double process2 = state.futureIndicators[Indicator.meetingEfficacy]! * 0.2 + state.futureIndicators[Indicator.alignedTech]! * 0.4 + state.futureIndicators[Indicator.collabProcesses]! * 0.4;
    double leadership2 = state.futureIndicators[Indicator.purposeDriven]! * 0.4 + state.futureIndicators[Indicator.empoweredLeadership]! * 0.6;

    double align = state.align1 * 0.35 + align2 * 0.65;
    double people = state.people1 * 0.35 + people2 * 0.65;
    double process = state.process1 * 0.35 + process2 * 0.65;
    double leadership = state.leadership1 * 0.35 + leadership2 * 0.65;
    double general = currentIndicators[Indicator.general]!;

    double futureCompanyEScore = align * 0.15 + people * 0.25 + process * 0.2 + leadership * 0.3 + general * 0.1;

    final double profitIncrease;
    final double costDecrease;
    final double marginIncrease;
    final double employeProductivityIncrease;

    
  }
}
