import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/survey_metrics_provider.dart';
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
      print('Normalized $indicator: ${value / 100}');
    });
    currentIndicators = normalizedIndicators;

    // Calculate future indicators
    for (var indicator in state.indicatorIncreasePercent.keys) {
      double newValue = currentIndicators[indicator]! * (state.indicatorIncreasePercent[indicator]! + 1);
      futureIndicators[indicator] = newValue > 0.9 ? 0.9 : newValue; //Cap value of indicator at 90%
      print('New indicator value $indicator: $newValue');
    }

    double align = futureIndicators[Indicator.growthAlign]! * 0.3 + futureIndicators[Indicator.orgAlign]! * 0.2 + futureIndicators[Indicator.collabKPIs]! * 0.5;
    double process = futureIndicators[Indicator.alignedTech]! * 0.4 + futureIndicators[Indicator.collabProcesses]! * 0.4 + futureIndicators[Indicator.meetingEfficacy]! * 0.2;
    double people = futureIndicators[Indicator.crossFuncComms]! * 0.3 + futureIndicators[Indicator.crossFuncAcc]! * 0.3 + futureIndicators[Indicator.engagedCommunity]! * 0.4;
    double leadership = futureIndicators[Indicator.empoweredLeadership]! * 0.6 + futureIndicators[Indicator.purposeDriven]! * 0.4;
    print('align: $align, process: $process, people: $people, leadership: $leadership');
    // Calculate future company score
    double futureCompanyEScore = align * 0.2 + process * 0.25 + people * 0.25 + leadership * 0.3;
    print("Future Company Index Score: $futureCompanyEScore");
    // Calculate finance constants
    print('---- Calculating finance constants ----');
    double constProfit = (Finance.profit.b - Finance.profit.c) / (1 - math.exp(-0.8 * -Finance.profit.d));
    print('constProfit calculation: (${Finance.profit.b} - ${Finance.profit.c}) / (1 - math.exp(-0.8 * -${Finance.profit.d})) = $constProfit');

    double constCost = (Finance.cost.b - Finance.cost.c) / (1 - math.exp(-0.8 * -Finance.cost.d));
    print('constCost calculation: (${Finance.cost.b} - ${Finance.cost.c}) / (1 - math.exp(-0.8 * -${Finance.cost.d})) = $constCost');

    double constMargin = (Finance.margin.b - Finance.margin.c) / (1 - math.exp(-0.8 * -Finance.margin.d));
    print('constMargin calculation: (${Finance.margin.b} - ${Finance.margin.c}) / (1 - math.exp(-0.8 * -${Finance.margin.d})) = $constMargin');

    double constProductivity = (Finance.productivity.b - Finance.productivity.c) / (1 - math.exp(-0.8 * -Finance.productivity.d));
    print('constProductivity calculation: (${Finance.productivity.b} - ${Finance.productivity.c}) / (1 - math.exp(-0.8 * -${Finance.productivity.d})) = $constProductivity');

    double constTurnover = (Finance.turnover.b - Finance.turnover.c) / (1 - math.exp(-0.8 * -Finance.turnover.d));
    print('constTurnover calculation: (${Finance.turnover.b} - ${Finance.turnover.c}) / (1 - math.exp(-0.8 * -${Finance.turnover.d})) = $constTurnover');

    // Calculate current metrics
    print('---- Calculating current metrics ----');
    double currentCompanyIndex = currentIndicators[Indicator.companyIndex]!;
    print('currentCompanyIndex: $currentCompanyIndex');

    double currentMetricProfit = constProfit * (1 - math.exp(Finance.profit.d * currentCompanyIndex)) + Finance.profit.c;
    print('currentMetricProfit calculation: $constProfit * (1 - math.exp(${Finance.profit.d} * $currentCompanyIndex)) + ${Finance.profit.c} = $currentMetricProfit');

    double currentMetricCost = constCost * (1 - math.exp(Finance.cost.d * currentCompanyIndex)) + Finance.cost.c;
    print('currentMetricCost calculation: $constCost * (1 - math.exp(${Finance.cost.d} * $currentCompanyIndex)) + ${Finance.cost.c} = $currentMetricCost');

    double currentMetricMargin = constMargin * (1 - math.exp(Finance.margin.d * currentCompanyIndex)) + Finance.margin.c;
    print('currentMetricMargin calculation: $constMargin * (1 - math.exp(${Finance.margin.d} * $currentCompanyIndex)) + ${Finance.margin.c} = $currentMetricMargin');

    double currentMetricProductivity = constProductivity * (1 - math.exp(Finance.productivity.d * currentCompanyIndex)) + Finance.productivity.c;
    print('currentMetricProductivity calculation: $constProductivity * (1 - math.exp(${Finance.productivity.d} * $currentCompanyIndex)) + ${Finance.productivity.c} = $currentMetricProductivity');

    double currentMetricTurnover = constTurnover * (1 - math.exp(Finance.turnover.d * currentCompanyIndex)) + Finance.turnover.c;
    print('currentMetricTurnover calculation: $constTurnover * (1 - math.exp(${Finance.turnover.d} * $currentCompanyIndex)) + ${Finance.turnover.c} = $currentMetricTurnover');

    // Calculate future metrics
    print('---- Calculating future metrics ----');
    double futureMetricProfit = constProfit * (1 - math.exp(Finance.profit.d * futureCompanyEScore)) + Finance.profit.c;
    print('futureMetricProfit calculation: $constProfit * (1 - math.exp(${Finance.profit.d} * $futureCompanyEScore)) + ${Finance.profit.c} = $futureMetricProfit');

    double futureMetricCost = constCost * (1 - math.exp(Finance.cost.d * futureCompanyEScore)) + Finance.cost.c;
    print('futureMetricCost calculation: $constCost * (1 - math.exp(${Finance.cost.d} * $futureCompanyEScore)) + ${Finance.cost.c} = $futureMetricCost');

    double futureMetricMargin = constMargin * (1 - math.exp(Finance.margin.d * futureCompanyEScore)) + Finance.margin.c;
    print('futureMetricMargin calculation: $constMargin * (1 - math.exp(${Finance.margin.d} * $futureCompanyEScore)) + ${Finance.margin.c} = $futureMetricMargin');

    double futureMetricProductivity = constProductivity * (1 - math.exp(Finance.productivity.d * futureCompanyEScore)) + Finance.productivity.c;
    print('futureMetricProductivity calculation: $constProductivity * (1 - math.exp(${Finance.productivity.d} * $futureCompanyEScore)) + ${Finance.productivity.c} = $futureMetricProductivity');

    double futureMetricTurnover = constTurnover * (1 - math.exp(Finance.turnover.d * futureCompanyEScore)) + Finance.turnover.c;
    print('futureMetricTurnover calculation: $constTurnover * (1 - math.exp(${Finance.turnover.d} * $futureCompanyEScore)) + ${Finance.turnover.c} = $futureMetricTurnover');

    // Calculate actual increases
    print('---- Calculating actual increases ----');
    double actualIncreaseProfit = futureMetricProfit - currentMetricProfit;
    print('actualIncreaseProfit calculation: $futureMetricProfit - $currentMetricProfit = $actualIncreaseProfit');

    double actualIncreaseCost = futureMetricCost - currentMetricCost;
    print('actualIncreaseCost calculation: $futureMetricCost - $currentMetricCost = $actualIncreaseCost');

    double actualIncreaseMargin = futureMetricMargin - currentMetricMargin;
    print('actualIncreaseMargin calculation: $futureMetricMargin - $currentMetricMargin = $actualIncreaseMargin');

    double actualIncreaseProductivity = futureMetricProductivity - currentMetricProductivity;
    print('actualIncreaseProductivity calculation: $futureMetricProductivity - $currentMetricProductivity = $actualIncreaseProductivity');

    double actualIncreaseTurnover = futureMetricTurnover - currentMetricTurnover;
    print('actualIncreaseTurnover calculation: $futureMetricTurnover - $currentMetricTurnover = $actualIncreaseTurnover');

    // Calculate time-adjusted changes
    print('---- Calculating time-adjusted changes ----');
    double changeMetricProfit = actualIncreaseProfit * (state.timeFrame / 5);
    print('changeMetricProfit calculation: $actualIncreaseProfit * (${state.timeFrame} / 5) = $changeMetricProfit');

    double changeMetricCost = actualIncreaseCost * (state.timeFrame / 5);
    print('changeMetricCost calculation: $actualIncreaseCost * (${state.timeFrame} / 5) = $changeMetricCost');

    double changeMetricMargin = actualIncreaseMargin * (state.timeFrame / 5);
    print('changeMetricMargin calculation: $actualIncreaseMargin * (${state.timeFrame} / 5) = $changeMetricMargin');

    double changeMetricProductivity = actualIncreaseProductivity * (state.timeFrame / 5);
    print('changeMetricProductivity calculation: $actualIncreaseProductivity * (${state.timeFrame} / 5) = $changeMetricProductivity');

    double changeMetricTurnover = actualIncreaseTurnover * (state.timeFrame / 5);
    print('changeMetricTurnover calculation: $actualIncreaseTurnover * (${state.timeFrame} / 5) = $changeMetricTurnover');

    // Update state
    print('---- Updating state with calculated values ----');
    print('Setting profitIncrease: $changeMetricProfit');
    print('Setting costDecrease: $changeMetricCost');
    print('Setting marginIncrease: $changeMetricMargin');
    print('Setting employeProductivityIncrease: $changeMetricProductivity');
    print('Setting turnoverDecrease: $changeMetricTurnover');

    state = state.copyWith(
      profitIncrease: changeMetricProfit * 100,
      costDecrease: changeMetricCost * 100,
      marginIncrease: changeMetricMargin * 100,
      employeProductivityIncrease: changeMetricProductivity * 100,
      turnoverDecrease: changeMetricTurnover * 100,
    );

    print('---- Completed calculateFinanceValues() ----');
  }
}
