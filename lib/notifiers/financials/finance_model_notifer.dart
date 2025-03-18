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
    // Get and normalize current indicators
    Map<Indicator, double> currentIndicators = metricsDataProvider.getCurrentSurveyMetric().companyBenchmarks;

    Map<Indicator, double> normalizedIndicators = {};
    currentIndicators.forEach((indicator, value) {
      normalizedIndicators[indicator] = value / 100;
    });
    currentIndicators = normalizedIndicators;

    // Calculate level 2 values
    double align2 = currentIndicators[Indicator.growthAlign]! * 0.3 + currentIndicators[Indicator.collabKPIs]! * 0.5 + currentIndicators[Indicator.orgAlign]! * 0.2;
    double people2 = currentIndicators[Indicator.engagedCommunity]! * 0.4 + currentIndicators[Indicator.crossFuncComms]! * 0.3 + currentIndicators[Indicator.crossFuncAcc]! * 0.3;
    double process2 = currentIndicators[Indicator.meetingEfficacy]! * 0.2 + currentIndicators[Indicator.alignedTech]! * 0.4 + currentIndicators[Indicator.collabProcesses]! * 0.4;
    double leadership2 = currentIndicators[Indicator.purposeDriven]! * 0.4 + currentIndicators[Indicator.empoweredLeadership]! * 0.6;

    // Calculate level 1 values
    double align1 = (currentIndicators[Indicator.align]! - align2 * 0.65) / 0.35;
    double people1 = (currentIndicators[Indicator.people]! - people2 * 0.65) / 0.35;
    double process1 = (currentIndicators[Indicator.process]! - process2 * 0.65) / 0.35;
    double leadership1 = (currentIndicators[Indicator.leadership]! - leadership2 * 0.65) / 0.35;

    // Update state
    state = state.copyWith(align1: align1, people1: people1, process1: process1, leadership1: leadership1);
    calculateFinanceValues();
  }

  void timeFrameChange(double timeFrame) {
    state = state.copyWith(timeFrame: timeFrame);
    calculateFinanceValues();
  }

  void calculateFinanceValues() {
    // Get and normalize current indicators
    Map<Indicator, double> currentIndicators = metricsDataProvider.getCurrentSurveyMetric().companyBenchmarks;

    Map<Indicator, double> futureIndicators = {};
    Map<Indicator, double> normalizedIndicators = {};

    currentIndicators.forEach((indicator, value) {
      normalizedIndicators[indicator] = value / 100;
    });
    currentIndicators = normalizedIndicators;

    // Calculate future indicators
    for (var indicator in state.indicatorIncreasePercent.keys) {
      double newVavlue = currentIndicators[indicator]! * (state.indicatorIncreasePercent[indicator]! + 1);
      futureIndicators[indicator] = newVavlue > 0.9 ? 0.9 : newVavlue; //Cap value of indicator at 90%
    }

    // Calculate level 2 values
    double align2 = futureIndicators[Indicator.growthAlign]! * 0.3 + futureIndicators[Indicator.collabKPIs]! * 0.5 + futureIndicators[Indicator.orgAlign]! * 0.2;
    double people2 = futureIndicators[Indicator.engagedCommunity]! * 0.4 + futureIndicators[Indicator.crossFuncComms]! * 0.3 + futureIndicators[Indicator.crossFuncAcc]! * 0.3;
    double process2 = futureIndicators[Indicator.meetingEfficacy]! * 0.2 + futureIndicators[Indicator.alignedTech]! * 0.4 + futureIndicators[Indicator.collabProcesses]! * 0.4;
    double leadership2 = futureIndicators[Indicator.purposeDriven]! * 0.4 + futureIndicators[Indicator.empoweredLeadership]! * 0.6;

    // Calculate combined values
    double align = (state.align1 * 0.35 + align2 * 0.65);
    double people = (state.people1 * 0.35 + people2 * 0.65);
    double process = (state.process1 * 0.35 + process2 * 0.65);
    double leadership = (state.leadership1 * 0.35 + leadership2 * 0.65);
    double general = (currentIndicators[Indicator.general]!);

    // Calculate future company score
    double futureCompanyEScore = (align * 0.15 + people * 0.25 + process * 0.2 + leadership * 0.3 + general * 0.1);
    // Calculate finance constants
    double constProfit = (Finance.profit.b - Finance.profit.c) / (1 - math.exp(-0.8 * -Finance.profit.d));
    double constCost = (Finance.cost.b - Finance.cost.c) / (1 - math.exp(-0.8 * -Finance.cost.d));
    double constMargin = (Finance.margin.b - Finance.margin.c) / (1 - math.exp(-0.8 * -Finance.margin.d));
    double constProductivity = (Finance.productivity.b - Finance.productivity.c) / (1 - math.exp(-0.8 * -Finance.productivity.d));
    double constTurnover = (Finance.turnover.b - Finance.turnover.c) / (1 - math.exp(-0.8 * -Finance.turnover.d));

    // Calculate current metrics
    double currentCompanyIndex = currentIndicators[Indicator.companyIndex]!;
    double currentMetricProfit = constProfit * (1 - math.exp(Finance.profit.d * currentCompanyIndex)) + Finance.profit.c;
    double currentMetricCost = constCost * (1 - math.exp(Finance.cost.d * currentCompanyIndex)) + Finance.cost.c;
    double currentMetricMargin = constMargin * (1 - math.exp(Finance.margin.d * currentCompanyIndex)) + Finance.margin.c;
    double currentMetricProductivity = constProductivity * (1 - math.exp(Finance.productivity.d * currentCompanyIndex)) + Finance.productivity.c;
    double currentMetricTurnover = constTurnover * (1 - math.exp(Finance.turnover.d * currentCompanyIndex)) + Finance.turnover.c;

    // Calculate future metrics
    double futureMetricProfit = constProfit * (1 - math.exp(Finance.profit.d * futureCompanyEScore)) + Finance.profit.c;
    double futureMetricCost = constCost * (1 - math.exp(Finance.cost.d * futureCompanyEScore)) + Finance.cost.c;
    double futureMetricMargin = constMargin * (1 - math.exp(Finance.margin.d * futureCompanyEScore)) + Finance.margin.c;
    double futureMetricProductivity = constProductivity * (1 - math.exp(Finance.productivity.d * futureCompanyEScore)) + Finance.productivity.c;
    double futureMetricTurnover = constTurnover * (1 - math.exp(Finance.turnover.d * futureCompanyEScore)) + Finance.turnover.c;

    // Calculate actual increases
    double actualIncreaseProfit = futureMetricProfit - currentMetricProfit;
    double actualIncreaseCost = futureMetricCost - currentMetricCost;
    double actualIncreaseMargin = futureMetricMargin - currentMetricMargin;
    double actualIncreaseProductivity = futureMetricProductivity - currentMetricProductivity;
    double actualIncreaseTurnover = futureMetricTurnover - currentMetricTurnover;

    // Calculate time-adjusted changes
    double changeMetricProfit = actualIncreaseProfit * (state.timeFrame / 5);
    double changeMetricCost = actualIncreaseCost * (state.timeFrame / 5);
    double changeMetricMargin = actualIncreaseMargin * (state.timeFrame / 5);
    double changeMetricProductivity = actualIncreaseProductivity * (state.timeFrame / 5);
    double changeMetricTurnover = actualIncreaseTurnover * (state.timeFrame / 5);

    // Update state
    state = state.copyWith(
      profitIncrease: changeMetricProfit,
      costDecrease: changeMetricCost,
      marginIncrease: changeMetricMargin,
      employeProductivityIncrease: changeMetricProductivity,
      turnoverDecrease: changeMetricTurnover,
    );
  }
}
