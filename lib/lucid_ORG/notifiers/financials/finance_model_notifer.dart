import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/survey_metrics_provider.dart';
import 'dart:math' as math;

class FinanceModelState {
  final double profitIncrease;
  final double costDecrease;
  final double marginIncrease;
  final double employeProductivityIncrease;
  final double turnoverDecrease;
  final double timeFrame;
  final Map<Indicator, double> futureIndicators;
  final Map<Finance, double> financeConst;
  final Map<Indicator, double> currentIndicators;

  FinanceModelState({
    required this.profitIncrease,
    required this.costDecrease,
    required this.marginIncrease,
    required this.employeProductivityIncrease,
    required this.timeFrame,
    required this.futureIndicators,
    required this.turnoverDecrease,
    required this.financeConst,
    required this.currentIndicators,
  });

  factory FinanceModelState.initial() {
    double constProfit = (Finance.profit.b - Finance.profit.c) / (1 - math.exp(-0.8 * -Finance.profit.d));
    double constCost = (Finance.cost.b - Finance.cost.c) / (1 - math.exp(-0.8 * -Finance.cost.d));
    double constMargin = (Finance.margin.b - Finance.margin.c) / (1 - math.exp(-0.8 * -Finance.margin.d));
    double constProductivity = (Finance.productivity.b - Finance.productivity.c) / (1 - math.exp(-0.8 * -Finance.productivity.d));
    double constTurnover = (Finance.turnover.b - Finance.turnover.c) / (1 - math.exp(-0.8 * -Finance.turnover.d));

    return FinanceModelState(
      profitIncrease: 0.0,
      costDecrease: 0.0,
      marginIncrease: 0.0,
      employeProductivityIncrease: 0.0,
      turnoverDecrease: 0.0,
      timeFrame: 2,
      futureIndicators: {
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
      currentIndicators: {},
      financeConst: {
        Finance.cost: constCost,
        Finance.margin: constMargin,
        Finance.productivity: constProductivity,
        Finance.profit: constProfit,
        Finance.turnover: constTurnover,
      },
    );
  }

  FinanceModelState copyWith({
    double? profitIncrease,
    double? costDecrease,
    double? marginIncrease,
    double? employeProductivityIncrease,
    double? turnoverDecrease,
    double? timeFrame,
    Map<Indicator, double>? futureIndicators,
    Map<Finance, double>? financeConst,
    Map<Indicator, double>? currentIndicators,
  }) {
    return FinanceModelState(
      profitIncrease: profitIncrease ?? this.profitIncrease,
      costDecrease: costDecrease ?? this.costDecrease,
      marginIncrease: marginIncrease ?? this.marginIncrease,
      employeProductivityIncrease: employeProductivityIncrease ?? this.employeProductivityIncrease,
      turnoverDecrease: turnoverDecrease ?? this.turnoverDecrease,
      timeFrame: timeFrame ?? this.timeFrame,
      futureIndicators: futureIndicators ?? this.futureIndicators,
      financeConst: financeConst ?? this.financeConst,
      currentIndicators: currentIndicators ?? this.currentIndicators,
    );
  }
}

class FinanceModelNotifer extends StateNotifier<FinanceModelState> {
  final MetricsDataNotifier surveyMetricNotifer;

  FinanceModelNotifer({required this.surveyMetricNotifer}) : super(FinanceModelState.initial());

  void sliderChange(Indicator indicator, double newValue) {
    state.futureIndicators[indicator] = newValue > 0.8 ? 0.8 : newValue;
    calculateFinanceValues();
  }

  double? getCurrentValue(Indicator indicator) {
    return state.currentIndicators[indicator];
  }

  double getCurrentTimeFrame() {
    return state.timeFrame;
  }

  void timeFrameChange(double timeFrame) {
    state = state.copyWith(timeFrame: timeFrame);
    calculateFinanceValues();
  }

  void calculateInitValues() {
    // Calculate finance constants
    print('---- Calculating finance constants ----');
    double constProfit = (Finance.profit.b - Finance.profit.c) / (1 - math.exp(-0.8 * Finance.profit.d));
    double constCost = (Finance.cost.b - Finance.cost.c) / (1 - math.exp(-0.8 * Finance.cost.d));
    double constMargin = (Finance.margin.b - Finance.margin.c) / (1 - math.exp(-0.8 * Finance.margin.d));
    double constProductivity = (Finance.productivity.b - Finance.productivity.c) / (1 - math.exp(-0.8 * Finance.productivity.d));
    double constTurnover = (Finance.turnover.b - Finance.turnover.c) / (1 - math.exp(-0.8 * Finance.turnover.d));
    print("Finance constants: constProfit: $constProfit, constCost: $constCost, constMargin: $constMargin, constProductivity: $constProductivity, constTurnover: $constTurnover");

    // Get the raw indicator maps
    Map<Indicator, double> currentRawIndicators = surveyMetricNotifer.getCurrentSurveyMetric().companyBenchmarks;
    Map<Indicator, double> futureRawIndicators = surveyMetricNotifer.getCurrentSurveyMetric().companyBenchmarks;

    // Divide all values by 100
    Map<Indicator, double> scaledCurrentIndicators = _scaleIndicators(currentRawIndicators);
    Map<Indicator, double> scaledFutureIndicators = _scaleIndicators(futureRawIndicators);

    state = state.copyWith(
      financeConst: {
        Finance.cost: constCost,
        Finance.margin: constMargin,
        Finance.productivity: constProductivity,
        Finance.profit: constProfit,
        Finance.turnover: constTurnover,
      },
      currentIndicators: scaledCurrentIndicators,
      futureIndicators: scaledFutureIndicators,
    );
    calculateFinanceValues();
  }

  /// Scales indicator values by dividing each by 100
  Map<Indicator, double> _scaleIndicators(Map<Indicator, double> indicators) {
    Map<Indicator, double> scaledMap = {};

    // Divide each value by 100
    indicators.forEach((indicator, value) {
      scaledMap[indicator] = value / 100.0;
    });

    return scaledMap;
  }

  void calculateFinanceValues() {
    print('==== STARTING FINANCE CALCULATIONS ====');

    // Get and normalize current indicators
    print('Fetching current and future indicators...');
    Map<Indicator, double> currentIndicators = state.currentIndicators;
    print('Current indicators: $currentIndicators');

    Map<Indicator, double> futureIndicators = state.futureIndicators;
    print('Future indicators: $futureIndicators');

    print('\n==== CALCULATING COMPONENT SCORES ====');
    double align = futureIndicators[Indicator.growthAlign]! * 0.3 + futureIndicators[Indicator.orgAlign]! * 0.2 + futureIndicators[Indicator.collabKPIs]! * 0.5;
    print('Align calculation: (${futureIndicators[Indicator.growthAlign]} * 0.3) + (${futureIndicators[Indicator.orgAlign]} * 0.2) + (${futureIndicators[Indicator.collabKPIs]} * 0.5) = $align');

    double process = futureIndicators[Indicator.alignedTech]! * 0.4 + futureIndicators[Indicator.collabProcesses]! * 0.4 + futureIndicators[Indicator.meetingEfficacy]! * 0.2;
    print(
        'Process calculation: (${futureIndicators[Indicator.alignedTech]} * 0.4) + (${futureIndicators[Indicator.collabProcesses]} * 0.4) + (${futureIndicators[Indicator.meetingEfficacy]} * 0.2) = $process');

    double people = futureIndicators[Indicator.crossFuncComms]! * 0.3 + futureIndicators[Indicator.crossFuncAcc]! * 0.3 + futureIndicators[Indicator.engagedCommunity]! * 0.4;
    print(
        'People calculation: (${futureIndicators[Indicator.crossFuncComms]} * 0.3) + (${futureIndicators[Indicator.crossFuncAcc]} * 0.3) + (${futureIndicators[Indicator.engagedCommunity]} * 0.4) = $people');

    double leadership = futureIndicators[Indicator.empoweredLeadership]! * 0.6 + futureIndicators[Indicator.purposeDriven]! * 0.4;
    print('Leadership calculation: (${futureIndicators[Indicator.empoweredLeadership]} * 0.6) + (${futureIndicators[Indicator.purposeDriven]} * 0.4) = $leadership');

    print('Component scores summary - align: $align, process: $process, people: $people, leadership: $leadership');

    print('\n==== CALCULATING FUTURE COMPANY SCORE ====');
    // Calculate future company score
    double futureCompanyEScore = align * 0.2 + process * 0.25 + people * 0.25 + leadership * 0.3;
    print('Future Company Score: ($align * 0.2) + ($process * 0.25) + ($people * 0.25) + ($leadership * 0.3) = $futureCompanyEScore');

    print('\n==== CALCULATING CURRENT METRICS ====');
    // Calculate current metrics
    double currentCompanyIndex = currentIndicators[Indicator.companyIndex]!;
    print('Current Company Index: $currentCompanyIndex');

    print('\nCurrent Profit:');
    double currentMetricProfit = state.financeConst[Finance.profit]! * (1 - math.exp(-Finance.profit.d * currentCompanyIndex)) + Finance.profit.c;
    print('- Formula: ${state.financeConst[Finance.profit]} * (1 - math.exp(-${Finance.profit.d} * $currentCompanyIndex)) + ${Finance.profit.c}');
    print('- Calculation breakdown:');
    print('  * Base constant: ${state.financeConst[Finance.profit]}');
    print('  * Exponent value: -${Finance.profit.d} * $currentCompanyIndex = ${-Finance.profit.d * currentCompanyIndex}');
    print('  * Exponential term: math.exp(${-Finance.profit.d * currentCompanyIndex}) = ${math.exp(-Finance.profit.d * currentCompanyIndex)}');
    print('  * 1 - exponential: 1 - ${math.exp(-Finance.profit.d * currentCompanyIndex)} = ${1 - math.exp(-Finance.profit.d * currentCompanyIndex)}');
    print(
        '  * Multiplied by constant: ${state.financeConst[Finance.profit]} * ${1 - math.exp(-Finance.profit.d * currentCompanyIndex)} = ${state.financeConst[Finance.profit]! * (1 - math.exp(-Finance.profit.d * currentCompanyIndex))}');
    print('  * Final with offset: ${state.financeConst[Finance.profit]! * (1 - math.exp(-Finance.profit.d * currentCompanyIndex))} + ${Finance.profit.c} = $currentMetricProfit');

    print('\nCurrent Cost:');
    double currentMetricCost = state.financeConst[Finance.cost]! * (1 - math.exp(-Finance.cost.d * currentCompanyIndex)) + Finance.cost.c;
    print('- Formula: ${state.financeConst[Finance.cost]} * (1 - math.exp(-${Finance.cost.d} * $currentCompanyIndex)) + ${Finance.cost.c} = $currentMetricCost');

    print('\nCurrent Margin:');
    double currentMetricMargin = state.financeConst[Finance.margin]! * (1 - math.exp(-Finance.margin.d * currentCompanyIndex)) + Finance.margin.c;
    print('- Formula: ${state.financeConst[Finance.margin]} * (1 - math.exp(-${Finance.margin.d} * $currentCompanyIndex)) + ${Finance.margin.c} = $currentMetricMargin');

    print('\nCurrent Productivity:');
    double currentMetricProductivity = state.financeConst[Finance.productivity]! * (1 - math.exp(-Finance.productivity.d * currentCompanyIndex)) + Finance.productivity.c;
    print('- Formula: ${state.financeConst[Finance.productivity]} * (1 - math.exp(-${Finance.productivity.d} * $currentCompanyIndex)) + ${Finance.productivity.c} = $currentMetricProductivity');

    print('\nCurrent Turnover:');
    double currentMetricTurnover = state.financeConst[Finance.turnover]! * (1 - math.exp(-Finance.turnover.d * currentCompanyIndex)) + Finance.turnover.c;
    print('- Formula: ${state.financeConst[Finance.turnover]} * (1 - math.exp(-${Finance.turnover.d} * $currentCompanyIndex)) + ${Finance.turnover.c} = $currentMetricTurnover');

    print('\n==== CALCULATING FUTURE METRICS ====');
    // Calculate future metrics
    print('\nFuture Profit:');
    double futureMetricProfit = state.financeConst[Finance.profit]! * (1 - math.exp(-Finance.profit.d * futureCompanyEScore)) + Finance.profit.c;
    print('- Formula: ${state.financeConst[Finance.profit]} * (1 - math.exp(-${Finance.profit.d} * $futureCompanyEScore)) + ${Finance.profit.c} = $futureMetricProfit');
    print('- Calculation breakdown:');
    print('  * Base constant: ${state.financeConst[Finance.profit]}');
    print('  * Exponent value: -${Finance.profit.d} * $futureCompanyEScore = ${-Finance.profit.d * futureCompanyEScore}');
    print('  * Exponential term: math.exp(${-Finance.profit.d * futureCompanyEScore}) = ${math.exp(-Finance.profit.d * futureCompanyEScore)}');
    print('  * 1 - exponential: 1 - ${math.exp(-Finance.profit.d * futureCompanyEScore)} = ${1 - math.exp(-Finance.profit.d * futureCompanyEScore)}');
    print(
        '  * Multiplied by constant: ${state.financeConst[Finance.profit]} * ${1 - math.exp(-Finance.profit.d * futureCompanyEScore)} = ${state.financeConst[Finance.profit]! * (1 - math.exp(-Finance.profit.d * futureCompanyEScore))}');
    print('  * Final with offset: ${state.financeConst[Finance.profit]! * (1 - math.exp(-Finance.profit.d * futureCompanyEScore))} + ${Finance.profit.c} = $futureMetricProfit');

    print('\nFuture Cost:');
    double futureMetricCost = state.financeConst[Finance.cost]! * (1 - math.exp(-Finance.cost.d * futureCompanyEScore)) + Finance.cost.c;
    print('- Formula: ${state.financeConst[Finance.cost]} * (1 - math.exp(-${Finance.cost.d} * $futureCompanyEScore)) + ${Finance.cost.c} = $futureMetricCost');

    print('\nFuture Margin:');
    double futureMetricMargin = state.financeConst[Finance.margin]! * (1 - math.exp(-Finance.margin.d * futureCompanyEScore)) + Finance.margin.c;
    print('- Formula: ${state.financeConst[Finance.margin]} * (1 - math.exp(-${Finance.margin.d} * $futureCompanyEScore)) + ${Finance.margin.c} = $futureMetricMargin');

    print('\nFuture Productivity:');
    double futureMetricProductivity = state.financeConst[Finance.productivity]! * (1 - math.exp(-Finance.productivity.d * futureCompanyEScore)) + Finance.productivity.c;
    print('- Formula: ${state.financeConst[Finance.productivity]} * (1 - math.exp(-${Finance.productivity.d} * $futureCompanyEScore)) + ${Finance.productivity.c} = $futureMetricProductivity');

    print('\nFuture Turnover:');
    double futureMetricTurnover = state.financeConst[Finance.turnover]! * (1 - math.exp(-Finance.turnover.d * futureCompanyEScore)) + Finance.turnover.c;
    print('- Formula: ${state.financeConst[Finance.turnover]} * (1 - math.exp(-${Finance.turnover.d} * $futureCompanyEScore)) + ${Finance.turnover.c} = $futureMetricTurnover');

    print('\n==== CALCULATING METRIC INCREASES ====');
    // Calculate actual increases
    print('\nActual Increases:');
    double actualIncreaseProfit = futureMetricProfit - currentMetricProfit;
    print('Profit increase: $futureMetricProfit - $currentMetricProfit = $actualIncreaseProfit');

    double actualIncreaseCost = futureMetricCost - currentMetricCost;
    print('Cost increase: $futureMetricCost - $currentMetricCost = $actualIncreaseCost');

    double actualIncreaseMargin = futureMetricMargin - currentMetricMargin;
    print('Margin increase: $futureMetricMargin - $currentMetricMargin = $actualIncreaseMargin');

    double actualIncreaseProductivity = futureMetricProductivity - currentMetricProductivity;
    print('Productivity increase: $futureMetricProductivity - $currentMetricProductivity = $actualIncreaseProductivity');

    double actualIncreaseTurnover = futureMetricTurnover - currentMetricTurnover;
    print('Turnover increase: $futureMetricTurnover - $currentMetricTurnover = $actualIncreaseTurnover');

    print('\n==== CALCULATING TIME-ADJUSTED CHANGES ====');
    // Calculate time-adjusted changes
    print('Time frame: ${state.timeFrame} years');
    print('Normalization factor: ${state.timeFrame} / 5 = ${state.timeFrame / 5}');

    print('\nTime-Adjusted Changes:');
    double changeMetricProfit = actualIncreaseProfit * (state.timeFrame / 5);
    print('Profit: $actualIncreaseProfit * ${state.timeFrame / 5} = $changeMetricProfit');

    double changeMetricCost = actualIncreaseCost * (state.timeFrame / 5);
    print('Cost: $actualIncreaseCost * ${state.timeFrame / 5} = $changeMetricCost');

    double changeMetricMargin = actualIncreaseMargin * (state.timeFrame / 5);
    print('Margin: $actualIncreaseMargin * ${state.timeFrame / 5} = $changeMetricMargin');

    double changeMetricProductivity = actualIncreaseProductivity * (state.timeFrame / 5);
    print('Productivity: $actualIncreaseProductivity * ${state.timeFrame / 5} = $changeMetricProductivity');

    double changeMetricTurnover = actualIncreaseTurnover * (state.timeFrame / 5);
    print('Turnover: $actualIncreaseTurnover * ${state.timeFrame / 5} = $changeMetricTurnover');

    print('\n==== UPDATING STATE ====');
    // Update state - multiply by 100 to convert to percentage
    print('Final values being set to state (as percentages):');
    print('- Profit increase: ${changeMetricProfit * 100}%');
    print('- Cost decrease: ${changeMetricCost * 100}%');
    print('- Margin increase: ${changeMetricMargin * 100}%');
    print('- Employee productivity increase: ${changeMetricProductivity * 100}%');
    print('- Turnover decrease: ${changeMetricTurnover * 100}%');

    // Update state
    state = state.copyWith(
      profitIncrease: changeMetricProfit,
      costDecrease: changeMetricCost,
      marginIncrease: changeMetricMargin ,
      employeProductivityIncrease: changeMetricProductivity,
      turnoverDecrease: changeMetricTurnover,
    );
    print('\n==== FINANCE CALCULATIONS COMPLETE ====');
  }
}
