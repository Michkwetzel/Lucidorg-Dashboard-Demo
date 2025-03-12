import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/surveyMetrics/survey_metrics_provider.dart';
import 'dart:math' as math;

class FinanceModelState {
  final double profitIncrease;
  final double costDecrease;
  final double marginIncrease;
  final double employeProductivityIncrease;
  final double turnoverDecrease;
  final double timeFrame;
  final Map<Indicator, double> indicatorIncreasePercent;

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
    required this.indicatorIncreasePercent,
    required this.align1,
    required this.people1,
    required this.process1,
    required this.leadership1,
    required this.turnoverDecrease,
  });

  factory FinanceModelState.initial() {
    return FinanceModelState(
      profitIncrease: 0.0,
      costDecrease: 0.0,
      marginIncrease: 0.0,
      employeProductivityIncrease: 0.0,
      turnoverDecrease: 0.0,
      timeFrame: 2,
      indicatorIncreasePercent: {
        Indicator.orgAlign: 0.2,
        Indicator.growthAlign: 0.4,
        Indicator.collabKPIs: 0.2,
        Indicator.engagedCommunity: 0.6,
        Indicator.crossFuncComms: 0.4,
        Indicator.crossFuncAcc: 0.2,
        Indicator.alignedTech: 0.2,
        Indicator.collabProcesses: 0.4,
        Indicator.meetingEfficacy: 0.2,
        Indicator.purposeDriven: 0.6,
        Indicator.empoweredLeadership: 0.2,
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
    double? turnoverDecrease,
    double? timeFrame,
    Map<Indicator, double>? indicatorIncreasePercent,
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
      turnoverDecrease: turnoverDecrease ?? this.turnoverDecrease,
      timeFrame: timeFrame ?? this.timeFrame,
      indicatorIncreasePercent: indicatorIncreasePercent ?? this.indicatorIncreasePercent,
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
    state.indicatorIncreasePercent[indicator] = increase;
    calculateFinanceValues();
  }

  double getCurrentValue(Indicator indicator) {
    return state.indicatorIncreasePercent[indicator]!;
  }

  double getCurrentTimeFrame() {
    return state.timeFrame;
  }

  void calculateInitialValues() {
    print('\n========== INITIAL VALUES CALCULATION START ==========');

    // Get and normalize current indicators
    print('\n----- INDICATORS DATA -----');
    Map<Indicator, double> currentIndicators = metricsDataProvider.getCurrentSurveyMetric().companyBenchmarks;
    print('ORIGINAL INDICATORS: $currentIndicators');

    Map<Indicator, double> normalizedIndicators = {};
    currentIndicators.forEach((indicator, value) {
      normalizedIndicators[indicator] = value / 100;
    });
    currentIndicators = normalizedIndicators;
    print('NORMALIZED INDICATORS: $currentIndicators');

    // Calculate level 2 values
    print('\n----- LEVEL 2 CALCULATIONS -----');
    double align2 = currentIndicators[Indicator.growthAlign]! * 0.3 + currentIndicators[Indicator.collabKPIs]! * 0.5 + currentIndicators[Indicator.orgAlign]! * 0.2;
    print('ALIGN2: ${currentIndicators[Indicator.growthAlign]} * 0.3 + ${currentIndicators[Indicator.collabKPIs]} * 0.5 + ${currentIndicators[Indicator.orgAlign]} * 0.2 = $align2');

    double people2 = currentIndicators[Indicator.engagedCommunity]! * 0.4 + currentIndicators[Indicator.crossFuncComms]! * 0.3 + currentIndicators[Indicator.crossFuncAcc]! * 0.3;
    print('PEOPLE2: ${currentIndicators[Indicator.engagedCommunity]} * 0.4 + ${currentIndicators[Indicator.crossFuncComms]} * 0.3 + ${currentIndicators[Indicator.crossFuncAcc]} * 0.3 = $people2');

    double process2 = currentIndicators[Indicator.meetingEfficacy]! * 0.2 + currentIndicators[Indicator.alignedTech]! * 0.4 + currentIndicators[Indicator.collabProcesses]! * 0.4;
    print('PROCESS2: ${currentIndicators[Indicator.meetingEfficacy]} * 0.2 + ${currentIndicators[Indicator.alignedTech]} * 0.4 + ${currentIndicators[Indicator.collabProcesses]} * 0.4 = $process2');

    double leadership2 = currentIndicators[Indicator.purposeDriven]! * 0.4 + currentIndicators[Indicator.empoweredLeadership]! * 0.6;
    print('LEADERSHIP2: ${currentIndicators[Indicator.purposeDriven]} * 0.4 + ${currentIndicators[Indicator.empoweredLeadership]} * 0.6 = $leadership2');

    // Calculate level 1 values
    print('\n----- LEVEL 1 CALCULATIONS -----');
    double align1 = (currentIndicators[Indicator.align]! - align2 * 0.65) / 0.35;
    print('ALIGN1: (${currentIndicators[Indicator.align]} - $align2 * 0.65) / 0.35 = $align1');

    double people1 = (currentIndicators[Indicator.people]! - people2 * 0.65) / 0.35;
    print('PEOPLE1: (${currentIndicators[Indicator.people]} - $people2 * 0.65) / 0.35 = $people1');

    double process1 = (currentIndicators[Indicator.process]! - process2 * 0.65) / 0.35;
    print('PROCESS1: (${currentIndicators[Indicator.process]} - $process2 * 0.65) / 0.35 = $process1');

    double leadership1 = (currentIndicators[Indicator.leadership]! - leadership2 * 0.65) / 0.35;
    print('LEADERSHIP1: (${currentIndicators[Indicator.leadership]} - $leadership2 * 0.65) / 0.35 = $leadership1');

    // Update state
    print('\n----- FINAL VALUES -----');
    print('FINAL VALUES: align1: $align1, people1: $people1, process1: $process1, leadership1: $leadership1');

    state = state.copyWith(align1: align1, people1: people1, process1: process1, leadership1: leadership1);
    print('STATE UPDATED');

    print('========== INITIAL VALUES CALCULATION END ==========\n');
    calculateFinanceValues();
  }

  void timeFrameChange(double timeFrame) {
    state = state.copyWith(timeFrame: timeFrame);
    calculateFinanceValues();
  }

  void calculateFinanceValues() {
    print('\n========== FINANCE VALUES CALCULATION START ==========');

    // Get and normalize current indicators
    print('\n----- INDICATORS DATA -----');
    Map<Indicator, double> currentIndicators = metricsDataProvider.getCurrentSurveyMetric().companyBenchmarks;
    print('ORIGINAL INDICATORS: $currentIndicators');

    Map<Indicator, double> futureIndicators = {};
    Map<Indicator, double> normalizedIndicators = {};

    currentIndicators.forEach((indicator, value) {
      normalizedIndicators[indicator] = value / 100;
    });
    currentIndicators = normalizedIndicators;
    print('NORMALIZED INDICATORS: $currentIndicators');

    // Calculate future indicators
    print('\n----- FUTURE INDICATORS CALCULATION -----');
    print('INDICATOR INCREASE PERCENTAGES: ${state.indicatorIncreasePercent}');

    for (var indicator in state.indicatorIncreasePercent.keys) {
      double newVavlue = currentIndicators[indicator]! * (state.indicatorIncreasePercent[indicator]! + 1);
      futureIndicators[indicator] = newVavlue > 0.9 ? 0.9 : newVavlue; //Cap value of indicator at 80%
      print('INDICATOR $indicator: Original: ${currentIndicators[indicator]}, New: $newVavlue, Capped: ${futureIndicators[indicator]}');
    }
    print('FUTURE INDICATORS SUMMARY: $futureIndicators');

    // Calculate level 2 values
    print('\n----- LEVEL 2 CALCULATIONS -----');
    double align2 = futureIndicators[Indicator.growthAlign]! * 0.3 + futureIndicators[Indicator.collabKPIs]! * 0.5 + futureIndicators[Indicator.orgAlign]! * 0.2;
    print('ALIGN2: ${futureIndicators[Indicator.growthAlign]} * 0.3 + ${futureIndicators[Indicator.collabKPIs]} * 0.5 + ${futureIndicators[Indicator.orgAlign]} * 0.2 = $align2');

    double people2 = futureIndicators[Indicator.engagedCommunity]! * 0.4 + futureIndicators[Indicator.crossFuncComms]! * 0.3 + futureIndicators[Indicator.crossFuncAcc]! * 0.3;
    print('PEOPLE2: ${futureIndicators[Indicator.engagedCommunity]} * 0.4 + ${futureIndicators[Indicator.crossFuncComms]} * 0.3 + ${futureIndicators[Indicator.crossFuncAcc]} * 0.3 = $people2');

    double process2 = futureIndicators[Indicator.meetingEfficacy]! * 0.2 + futureIndicators[Indicator.alignedTech]! * 0.4 + futureIndicators[Indicator.collabProcesses]! * 0.4;
    print('PROCESS2: ${futureIndicators[Indicator.meetingEfficacy]} * 0.2 + ${futureIndicators[Indicator.alignedTech]} * 0.4 + ${futureIndicators[Indicator.collabProcesses]} * 0.4 = $process2');

    double leadership2 = futureIndicators[Indicator.purposeDriven]! * 0.4 + futureIndicators[Indicator.empoweredLeadership]! * 0.6;
    print('LEADERSHIP2: ${futureIndicators[Indicator.purposeDriven]} * 0.4 + ${futureIndicators[Indicator.empoweredLeadership]} * 0.6 = $leadership2');

    // Calculate combined values
    print('\n----- COMBINED CALCULATIONS -----');
    double align = (state.align1 * 0.35 + align2 * 0.65);
    print('ALIGN: ${state.align1} * 0.35 + $align2 * 0.65 = $align');

    double people = (state.people1 * 0.35 + people2 * 0.65);
    print('PEOPLE: ${state.people1} * 0.35 + $people2 * 0.65 = $people');

    double process = (state.process1 * 0.35 + process2 * 0.65);
    print('PROCESS: ${state.process1} * 0.35 + $process2 * 0.65 = $process');

    double leadership = (state.leadership1 * 0.35 + leadership2 * 0.65);
    print('LEADERSHIP: ${state.leadership1} * 0.35 + $leadership2 * 0.65 = $leadership');

    double general = (currentIndicators[Indicator.general]!);
    print('GENERAL: $general');

    // Calculate future company score
    print('\n----- FUTURE COMPANY SCORE -----');
    double futureCompanyEScore = (align * 0.15 + people * 0.25 + process * 0.2 + leadership * 0.3 + general * 0.1);
    print('FUTURE COMPANY SCORE: $align * 0.15 + $people * 0.25 + $process * 0.2 + $leadership * 0.3 + $general * 0.1 = $futureCompanyEScore');

    // Calculate finance constants
    print('\n----- FINANCE CONSTANTS -----');
    double constProfit = (Finance.profit.b - Finance.profit.c) / (1 - math.exp(-0.8 * Finance.profit.d));
    print('PROFIT CONSTANT: (${Finance.profit.b} - ${Finance.profit.c}) / (1 - math.exp(-0.8 * ${Finance.profit.d})) = $constProfit');

    double constCost = (Finance.cost.b - Finance.cost.c) / (1 - math.exp(-0.8 * Finance.cost.d));
    print('COST CONSTANT: (${Finance.cost.b} - ${Finance.cost.c}) / (1 - math.exp(-0.8 * ${Finance.cost.d})) = $constCost');

    double constMargin = (Finance.margin.b - Finance.margin.c) / (1 - math.exp(-0.8 * Finance.margin.d));
    print('MARGIN CONSTANT: (${Finance.margin.b} - ${Finance.margin.c}) / (1 - math.exp(-0.8 * ${Finance.margin.d})) = $constMargin');

    double constProductivity = (Finance.productivity.b - Finance.productivity.c) / (1 - math.exp(-0.8 * Finance.productivity.d));
    print('PRODUCTIVITY CONSTANT: (${Finance.productivity.b} - ${Finance.productivity.c}) / (1 - math.exp(-0.8 * ${Finance.productivity.d})) = $constProductivity');

    double constTurnover = (Finance.turnover.b - Finance.turnover.c) / (1 - math.exp(-0.8 * Finance.turnover.d));
    print('TURNOVER CONSTANT: (${Finance.turnover.b} - ${Finance.turnover.c}) / (1 - math.exp(-0.8 * ${Finance.turnover.d})) = $constTurnover');

// Calculate current metrics
    print('\n----- CURRENT METRICS -----');
    double currentCompanyIndex = currentIndicators[Indicator.companyIndex]!;
    print('CURRENT COMPANY INDEX: $currentCompanyIndex');

    double currentMetricProfit = constProfit * (1 - math.exp(Finance.profit.d * currentCompanyIndex)) + Finance.profit.c;
    print('CURRENT PROFIT: $constProfit * (1 - math.exp(${Finance.profit.d} * $currentCompanyIndex)) + ${Finance.profit.c} = $currentMetricProfit');

    double currentMetricCost = constCost * (1 - math.exp(Finance.cost.d * currentCompanyIndex)) + Finance.cost.c;
    print('CURRENT COST: $constCost * (1 - math.exp(${Finance.cost.d} * $currentCompanyIndex)) + ${Finance.cost.c} = $currentMetricCost');

    double currentMetricMargin = constMargin * (1 - math.exp(Finance.margin.d * currentCompanyIndex)) + Finance.margin.c;
    print('CURRENT MARGIN: $constMargin * (1 - math.exp(${Finance.margin.d} * $currentCompanyIndex)) + ${Finance.margin.c} = $currentMetricMargin');

    double currentMetricProductivity = constProductivity * (1 - math.exp(Finance.productivity.d * currentCompanyIndex)) + Finance.productivity.c;
    print('CURRENT PRODUCTIVITY: $constProductivity * (1 - math.exp(${Finance.productivity.d} * $currentCompanyIndex)) + ${Finance.productivity.c} = $currentMetricProductivity');

    double currentMetricTurnover = constTurnover * (1 - math.exp(Finance.turnover.d * currentCompanyIndex)) + Finance.turnover.c;
    print('CURRENT TURNOVER: $constTurnover * (1 - math.exp(${Finance.turnover.d} * $currentCompanyIndex)) + ${Finance.turnover.c} = $currentMetricTurnover');

// Calculate future metrics
    print('\n----- FUTURE METRICS -----');
    print('FUTURE COMPANY SCORE: $futureCompanyEScore');

    double futureMetricProfit = constProfit * (1 - math.exp(Finance.profit.d * futureCompanyEScore)) + Finance.profit.c;
    print('FUTURE PROFIT: $constProfit * (1 - math.exp(${Finance.profit.d} * $futureCompanyEScore)) + ${Finance.profit.c} = $futureMetricProfit');

    double futureMetricCost = constCost * (1 - math.exp(Finance.cost.d * futureCompanyEScore)) + Finance.cost.c;
    print('FUTURE COST: $constCost * (1 - math.exp(${Finance.cost.d} * $futureCompanyEScore)) + ${Finance.cost.c} = $futureMetricCost');

    double futureMetricMargin = constMargin * (1 - math.exp(Finance.margin.d * futureCompanyEScore)) + Finance.margin.c;
    print('FUTURE MARGIN: $constMargin * (1 - math.exp(${Finance.margin.d} * $futureCompanyEScore)) + ${Finance.margin.c} = $futureMetricMargin');

    double futureMetricProductivity = constProductivity * (1 - math.exp(Finance.productivity.d * futureCompanyEScore)) + Finance.productivity.c;
    print('FUTURE PRODUCTIVITY: $constProductivity * (1 - math.exp(${Finance.productivity.d} * $futureCompanyEScore)) + ${Finance.productivity.c} = $futureMetricProductivity');

    double futureMetricTurnover = constTurnover * (1 - math.exp(Finance.turnover.d * futureCompanyEScore)) + Finance.turnover.c;
    print('FUTURE TURNOVER: $constTurnover * (1 - math.exp(${Finance.turnover.d} * $futureCompanyEScore)) + ${Finance.turnover.c} = $futureMetricTurnover');

// Calculate actual increases
    print('\n----- ACTUAL INCREASES -----');
    double actualIncreaseProfit = futureMetricProfit - currentMetricProfit;
    print('PROFIT INCREASE: $futureMetricProfit - $currentMetricProfit = $actualIncreaseProfit');

    double actualIncreaseCost = futureMetricCost - currentMetricCost;
    print('COST INCREASE: $futureMetricCost - $currentMetricCost = $actualIncreaseCost');

    double actualIncreaseMargin = futureMetricMargin - currentMetricMargin;
    print('MARGIN INCREASE: $futureMetricMargin - $currentMetricMargin = $actualIncreaseMargin');

    double actualIncreaseProductivity = futureMetricProductivity - currentMetricProductivity;
    print('PRODUCTIVITY INCREASE: $futureMetricProductivity - $currentMetricProductivity = $actualIncreaseProductivity');

    double actualIncreaseTurnover = futureMetricTurnover - currentMetricTurnover;
    print('TURNOVER INCREASE: $futureMetricTurnover - $currentMetricTurnover = $actualIncreaseTurnover');

    // Calculate time-adjusted changes
    print('\n----- TIME-ADJUSTED CHANGES -----');
    print('TIME FRAME: ${state.timeFrame} years');
    double changeMetricProfit = actualIncreaseProfit * (state.timeFrame / 5);
    double changeMetricCost = actualIncreaseCost * (state.timeFrame / 5);
    double changeMetricMargin = actualIncreaseMargin * (state.timeFrame / 5);
    double changeMetricProductivity = actualIncreaseProductivity * (state.timeFrame / 5);
    double changeMetricTurnover = actualIncreaseTurnover * (state.timeFrame / 5);

    print('Final PROFIT CHANGE: $changeMetricProfit');
    print('Final COST CHANGE: $changeMetricCost');
    print('Final MARGIN CHANGE: $changeMetricMargin');
    print('Final PRODUCTIVITY CHANGE: $changeMetricProductivity');
    print('Final TURNOVER CHANGE: $changeMetricTurnover');

    // Update state
    print('\n----- STATE UPDATE -----');
    state = state.copyWith(
      profitIncrease: changeMetricProfit,
      costDecrease: changeMetricCost,
      marginIncrease: changeMetricMargin,
      employeProductivityIncrease: changeMetricProductivity,
      turnoverDecrease: changeMetricTurnover,
    );
    print('STATE UPDATED WITH NEW FINANCIAL VALUES');

    print('========== FINANCE VALUES CALCULATION END ==========\n');
  }
}
