// Create a class for individual survey metrics
import 'dart:math';

import 'package:platform_front/config/enums.dart';

class SurveyMetric {
  final Map<Indicator, double> ceoBenchmarks;
  final Map<Indicator, double> cSuiteBenchmarks;
  final Map<Indicator, double> employeeBenchmarks;
  final Map<Indicator, double> companyBenchmarks;
  final Map<Indicator, double> diffScores;
  final double nCeoFinished;
  final double nCSuiteFinished;
  final double nEmployeeFinished;
  final double nSurveys;
  final double nStarted;
  final double nSubmitted;
  final String surveyName;
  final bool unableToCalculate; //Not all departments filled in survey

  SurveyMetric({
    required this.companyBenchmarks,
    required this.ceoBenchmarks,
    required this.cSuiteBenchmarks,
    required this.employeeBenchmarks,
    required this.diffScores,
    required this.nCeoFinished,
    required this.nCSuiteFinished,
    required this.nEmployeeFinished,
    required this.nSurveys,
    required this.nStarted,
    required this.nSubmitted,
    required this.surveyName,
    required this.unableToCalculate,
  });

  factory SurveyMetric.empty() {
    return SurveyMetric(
      companyBenchmarks: {},
      ceoBenchmarks: {},
      cSuiteBenchmarks: {},
      employeeBenchmarks: {},
      diffScores: {},
      nCeoFinished: 0,
      nCSuiteFinished: 0,
      nEmployeeFinished: 0,
      nSurveys: 0,
      nStarted: 0,
      nSubmitted: 0,
      surveyName: '',
      unableToCalculate: true,
    );
  }

  factory SurveyMetric.loadDefaultValues({double nCeoFinished = 1, double nCSuiteFinished = 4, double nEmployeeFinished = 12, double nSurveys = 20, double nStarted = 18}) {
    Map<Indicator, double> ceoBenchmarks = {
      Indicator.align: 58.3,
      Indicator.meetingEfficacy: 100.0,
      Indicator.leadership: 52.9,
      Indicator.companyIndex: 58.0,
      Indicator.workforce: 55.6,
      Indicator.orgAlign: 83.3,
      Indicator.alignedTech: 100.0,
      Indicator.growthAlign: 66.7,
      Indicator.collabKPIs: 50.0,
      Indicator.crossFuncAcc: 66.7,
      Indicator.crossFuncComms: 16.7,
      Indicator.people: 57.4,
      Indicator.engagedCommunity: 66.7,
      Indicator.collabProcesses: 50.0,
      Indicator.process: 73.0,
      Indicator.general: 44.0,
      Indicator.purposeDriven: 83.3,
      Indicator.operations: 67.1,
      Indicator.empoweredLeadership: 33.3
    };

    Map<Indicator, double> cSuiteBenchmarks = {
      Indicator.purposeDriven: 75.0,
      Indicator.meetingEfficacy: 91.7,
      Indicator.companyIndex: 61.2,
      Indicator.leadership: 61.9,
      Indicator.general: 52.0,
      Indicator.engagedCommunity: 83.3,
      Indicator.collabKPIs: 50.0,
      Indicator.process: 69.8,
      Indicator.people: 58.7,
      Indicator.collabProcesses: 50.0,
      Indicator.empoweredLeadership: 58.3,
      Indicator.alignedTech: 91.7,
      Indicator.crossFuncAcc: 58.3,
      Indicator.crossFuncComms: 16.7,
      Indicator.growthAlign: 83.3,
      Indicator.orgAlign: 58.3,
      Indicator.align: 59.0,
      Indicator.operations: 65.4,
      Indicator.workforce: 60.0
    };

    Map<Indicator, double> employeeBenchmarks = {
      Indicator.companyIndex: 53.9,
      Indicator.meetingEfficacy: 50.0,
      Indicator.growthAlign: 55.6,
      Indicator.collabProcesses: 55.6,
      Indicator.engagedCommunity: 55.6,
      Indicator.operations: 55.1,
      Indicator.general: 46.7,
      Indicator.crossFuncAcc: 55.6,
      Indicator.empoweredLeadership: 55.6,
      Indicator.align: 58.1,
      Indicator.workforce: 53.9,
      Indicator.process: 53.1,
      Indicator.crossFuncComms: 50.0,
      Indicator.alignedTech: 55.6,
      Indicator.purposeDriven: 55.6,
      Indicator.orgAlign: 77.8,
      Indicator.leadership: 56.2,
      Indicator.people: 52.3,
      Indicator.collabKPIs: 55.6
    };

    Map<Indicator, double> companyBenchmarks = {
      Indicator.purposeDriven: 61.8,
      Indicator.growthAlign: 62.8,
      Indicator.orgAlign: 73.5,
      Indicator.collabProcesses: 53.9,
      Indicator.collabKPIs: 53.9,
      Indicator.alignedTech: 66.7,
      Indicator.crossFuncComms: 40.2,
      Indicator.empoweredLeadership: 54.9,
      Indicator.engagedCommunity: 62.8,
      Indicator.meetingEfficacy: 62.7,
      Indicator.crossFuncAcc: 56.9,
      Indicator.companyIndex: 55.9,
      Indicator.workforce: 55.4,
      Indicator.operations: 58.3,
      Indicator.general: 47.8,
      Indicator.align: 58.3,
      Indicator.process: 58.2,
      Indicator.leadership: 57.3,
      Indicator.people: 54.1
    };

    Map<Indicator, double> differenceScores = {
      Indicator.purposeDriven: 27.8,
      Indicator.growthAlign: 27.8,
      Indicator.orgAlign: 25.0,
      Indicator.collabProcesses: 5.6,
      Indicator.collabKPIs: 5.6,
      Indicator.alignedTech: 44.4,
      Indicator.crossFuncComms: 33.3,
      Indicator.empoweredLeadership: 25.0,
      Indicator.engagedCommunity: 27.8,
      Indicator.meetingEfficacy: 50.0,
      Indicator.crossFuncAcc: 11.1,
      Indicator.companyIndex: 7.3,
      Indicator.workforce: 6.1,
      Indicator.operations: 12.0,
      Indicator.general: 8.0,
      Indicator.align: 0.8,
      Indicator.process: 19.9,
      Indicator.leadership: 9.0,
      Indicator.people: 6.4
    };

    String surveyName = 'Default';

    return SurveyMetric(
      ceoBenchmarks: ceoBenchmarks,
      cSuiteBenchmarks: cSuiteBenchmarks,
      employeeBenchmarks: employeeBenchmarks,
      companyBenchmarks: companyBenchmarks,
      diffScores: differenceScores,
      nCeoFinished: nCeoFinished,
      nCSuiteFinished: nCSuiteFinished,
      nEmployeeFinished: nEmployeeFinished,
      nSurveys: nSurveys,
      nStarted: nStarted,
      nSubmitted: nCeoFinished + nEmployeeFinished + nCSuiteFinished,
      surveyName: surveyName,
      unableToCalculate: false,
    );
  }

  factory SurveyMetric.loadBlurredData({String surveyName = 'Default', double nCeoFinished = 1, double nCSuiteFinished = 4, double nEmployeeFinished = 12, double nSurveys = 20, double nStarted = 18}) {
    Map<Indicator, double> ceoBenchmarks = {
      Indicator.align: 58.3,
      Indicator.meetingEfficacy: 100.0,
      Indicator.leadership: 52.9,
      Indicator.companyIndex: 2.0,
      Indicator.workforce: 55.6,
      Indicator.orgAlign: 83.3,
      Indicator.alignedTech: 100.0,
      Indicator.growthAlign: 66.7,
      Indicator.collabKPIs: 50.0,
      Indicator.crossFuncAcc: 66.7,
      Indicator.crossFuncComms: 16.7,
      Indicator.people: 57.4,
      Indicator.engagedCommunity: 66.7,
      Indicator.collabProcesses: 50.0,
      Indicator.process: 73.0,
      Indicator.general: 44.0,
      Indicator.purposeDriven: 83.3,
      Indicator.operations: 67.1,
      Indicator.empoweredLeadership: 33.3
    };

    Map<Indicator, double> cSuiteBenchmarks = {
      Indicator.purposeDriven: 75.0,
      Indicator.meetingEfficacy: 91.7,
      Indicator.companyIndex: 2.2,
      Indicator.leadership: 61.9,
      Indicator.general: 52.0,
      Indicator.engagedCommunity: 83.3,
      Indicator.collabKPIs: 50.0,
      Indicator.process: 69.8,
      Indicator.people: 58.7,
      Indicator.collabProcesses: 50.0,
      Indicator.empoweredLeadership: 58.3,
      Indicator.alignedTech: 91.7,
      Indicator.crossFuncAcc: 58.3,
      Indicator.crossFuncComms: 16.7,
      Indicator.growthAlign: 83.3,
      Indicator.orgAlign: 58.3,
      Indicator.align: 59.0,
      Indicator.operations: 65.4,
      Indicator.workforce: 60.0
    };

    Map<Indicator, double> employeeBenchmarks = {
      Indicator.companyIndex: 2.9,
      Indicator.meetingEfficacy: 50.0,
      Indicator.growthAlign: 55.6,
      Indicator.collabProcesses: 55.6,
      Indicator.engagedCommunity: 55.6,
      Indicator.operations: 55.1,
      Indicator.general: 46.7,
      Indicator.crossFuncAcc: 55.6,
      Indicator.empoweredLeadership: 55.6,
      Indicator.align: 58.1,
      Indicator.workforce: 53.9,
      Indicator.process: 53.1,
      Indicator.crossFuncComms: 50.0,
      Indicator.alignedTech: 55.6,
      Indicator.purposeDriven: 55.6,
      Indicator.orgAlign: 77.8,
      Indicator.leadership: 56.2,
      Indicator.people: 52.3,
      Indicator.collabKPIs: 55.6
    };

    Map<Indicator, double> companyBenchmarks = {
      Indicator.purposeDriven: 61.8,
      Indicator.growthAlign: 62.8,
      Indicator.orgAlign: 73.5,
      Indicator.collabProcesses: 53.9,
      Indicator.collabKPIs: 53.9,
      Indicator.alignedTech: 66.7,
      Indicator.crossFuncComms: 40.2,
      Indicator.empoweredLeadership: 54.9,
      Indicator.engagedCommunity: 62.8,
      Indicator.meetingEfficacy: 62.7,
      Indicator.crossFuncAcc: 56.9,
      Indicator.companyIndex: 2.1,
      Indicator.workforce: 55.4,
      Indicator.operations: 58.3,
      Indicator.general: 47.8,
      Indicator.align: 58.3,
      Indicator.process: 58.2,
      Indicator.leadership: 57.3,
      Indicator.people: 54.1
    };

    Map<Indicator, double> differenceScores = {
      Indicator.purposeDriven: 27.8,
      Indicator.growthAlign: 27.8,
      Indicator.orgAlign: 25.0,
      Indicator.collabProcesses: 5.6,
      Indicator.collabKPIs: 5.6,
      Indicator.alignedTech: 44.4,
      Indicator.crossFuncComms: 33.3,
      Indicator.empoweredLeadership: 25.0,
      Indicator.engagedCommunity: 27.8,
      Indicator.meetingEfficacy: 50.0,
      Indicator.crossFuncAcc: 11.1,
      Indicator.companyIndex: 7.3,
      Indicator.workforce: 6.1,
      Indicator.operations: 12.0,
      Indicator.general: 8.0,
      Indicator.align: 0.8,
      Indicator.process: 19.9,
      Indicator.leadership: 9.0,
      Indicator.people: 6.4
    };

   

    return SurveyMetric(
      ceoBenchmarks: ceoBenchmarks,
      cSuiteBenchmarks: cSuiteBenchmarks,
      employeeBenchmarks: employeeBenchmarks,
      companyBenchmarks: companyBenchmarks,
      diffScores: differenceScores,
      nCeoFinished: nCeoFinished,
      nCSuiteFinished: nCSuiteFinished,
      nEmployeeFinished: nEmployeeFinished,
      nSurveys: nSurveys,
      nStarted: nStarted,
      nSubmitted: nCeoFinished + nEmployeeFinished + nCSuiteFinished,
      surveyName: surveyName,
      unableToCalculate: false,
    );
  }

  factory SurveyMetric.fromStringFields({
    required Map<String, dynamic> ceoBenchmarks,
    required Map<String, dynamic> cSuiteBenchmarks,
    required Map<String, dynamic> employeeBenchmarks,
    required double nCeoFinished,
    required double nCSuiteFinished,
    required double nEmployeeFinished,
    required double nSurveys,
    required double nStarted,
    required String surveyName,
  }) {
    // Get String maps and convert to Enum Indicators.
    Map<Indicator, double> convertToBenchmarkMap(Map<String, dynamic> rawMap) {
      Map<Indicator, double> resultMap = {};

      for (Indicator indicator in Indicator.values) {
        String enumString = indicator.toString();
        List<String> parts = enumString.split('.');
        String key = parts.last;
        dynamic rawValue = rawMap[key];
        if (rawValue != null) {
          double value = rawValue.toDouble();
          if (value != 0.0) {
            resultMap[indicator] = value;
          }
        }
      }

      return resultMap;
    }

    Map<Indicator, double> ceoBenchmarksMap = convertToBenchmarkMap(ceoBenchmarks);
    Map<Indicator, double> cSuiteBenchmarksMap = convertToBenchmarkMap(cSuiteBenchmarks);
    Map<Indicator, double> employeeBenchmarksMap = convertToBenchmarkMap(employeeBenchmarks);
    Map<Indicator, double> companyBenchmarksMap = {};
    Map<Indicator, double> diffScoresMap = {};

    //Calculate combined company benchmark
    if (employeeBenchmarksMap.isNotEmpty && cSuiteBenchmarksMap.isNotEmpty && ceoBenchmarksMap.isNotEmpty) {
      for (final key in ceoBenchmarksMap.keys) {
        companyBenchmarksMap[key] = (((ceoBenchmarksMap[key]! * nCeoFinished) + (cSuiteBenchmarksMap[key]! * nCSuiteFinished) + (employeeBenchmarksMap[key]! * nEmployeeFinished)) /
            (nCeoFinished + nCSuiteFinished + nEmployeeFinished));
      }
      for (final key in ceoBenchmarksMap.keys) {
        double value1 = (ceoBenchmarksMap[key]! - cSuiteBenchmarksMap[key]!).abs();
        double value2 = (ceoBenchmarksMap[key]! - employeeBenchmarksMap[key]!).abs();
        double value3 = (cSuiteBenchmarksMap[key]! - employeeBenchmarksMap[key]!).abs();
        diffScoresMap[key] = max(value1, max(value2, value3));
      }
    }

    // Convert to percent. from 0.111 to 11.1
    Map<Indicator, double> convertBenchmarks(Map<Indicator, dynamic>? benchmarks) {
      return benchmarks?.map((key, value) {
            final numValue = value as num?;
            return MapEntry(key, numValue != null ? (((numValue.toDouble() * 1000).roundToDouble()) / 10) : 0.0);
          }) ??
          {};
    }

    return SurveyMetric(
      companyBenchmarks: convertBenchmarks(companyBenchmarksMap),
      ceoBenchmarks: convertBenchmarks(ceoBenchmarksMap),
      cSuiteBenchmarks: convertBenchmarks(cSuiteBenchmarksMap),
      employeeBenchmarks: convertBenchmarks(employeeBenchmarksMap),
      diffScores: convertBenchmarks(diffScoresMap),
      nCeoFinished: nCeoFinished,
      nCSuiteFinished: nCSuiteFinished,
      nEmployeeFinished: nEmployeeFinished,
      nSurveys: nSurveys,
      nStarted: nStarted,
      nSubmitted: nCeoFinished + nCSuiteFinished + nEmployeeFinished,
      surveyName: surveyName,
      unableToCalculate: companyBenchmarksMap.isEmpty ? true : false,
    );
  }

  double get getSurveyParticipation => double.parse((nSubmitted * 100 / nSurveys).toStringAsFixed(1));

  List<Map<Indicator, double>> getSpecificFoundations(List<Indicator> indicators) {
    List<Map<Indicator, double>> foundationIndicators = [];

    for (var indicator in indicators) {
      if (companyBenchmarks.containsKey(indicator)) {
        foundationIndicators.add({indicator: companyBenchmarks[indicator]!});
      }
    }

    return foundationIndicators;
  }

  Map<Indicator, double> returnJustIndicators(String mapName) {
    Map<Indicator, double> removeIndicators(Map<Indicator, double> originalMap) {
      // Create a new map instead of modifying the reference
      Map<Indicator, double> returnMap = Map.from(originalMap);

      // List of indicators to remove
      final indicatorsToRemove = [
        Indicator.align,
        Indicator.people,
        Indicator.process,
        Indicator.leadership,
        Indicator.companyIndex,
        Indicator.general,
        Indicator.workforce,
        Indicator.operations,
      ];

      // Remove all specified indicators
      for (final indicator in indicatorsToRemove) {
        returnMap.remove(indicator);
      }
      return returnMap;
    }

    // Get the appropriate map based on mapName
    Map<Indicator, double> sourceMap;
    switch (mapName) {
      case 'ceoBenchmarks':
        sourceMap = cSuiteBenchmarks;
        break;
      case 'cSuiteBenchmarks':
        sourceMap = cSuiteBenchmarks;
        break;
      case 'employeeBenchmarks':
        sourceMap = employeeBenchmarks;
        break;
      case 'diffScores':
        sourceMap = diffScores;
        break;
      case 'companyBenchmarks':
        sourceMap = companyBenchmarks;
        break;
      default:
        return {};
    }

    return removeIndicators(sourceMap);
  }

  List<Indicator> getHighestDiffIndicators(int n) {
    List<MapEntry<Indicator, double>> sortedEntries = returnJustIndicators('diffScores').entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    List<Indicator> indicators = [];
    for (var diff in sortedEntries.take(n)) {
      indicators.add(diff.key);
    }
    return indicators;
  }

  Indicator getLowestScoreIndicator() {
    List<MapEntry<Indicator, double>> benchmarkEntries = returnJustIndicators('companyBenchmarks').entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    return benchmarkEntries.first.key;
  }

  Indicator getHighestScoreIndicator() {
    List<MapEntry<Indicator, double>> benchmarkEntries = returnJustIndicators('companyBenchmarks').entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return benchmarkEntries.first.key;
  }

  List<Indicator> returnImpactChartIndicators() {
    List<Indicator> indicators = [];

    // Handle diff scores
    List<MapEntry<Indicator, double>> sortedEntries = returnJustIndicators('diffScores').entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    // Get top 3 indicators with value > 15
    for (var diff in sortedEntries.take(3)) {
      if (diff.value > 15) {
        indicators.add(diff.key);
      }
    }

    // Handle company benchmarks
    List<MapEntry<Indicator, double>> benchmarkEntries = returnJustIndicators('companyBenchmarks').entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    // Filter out indicators that are already selected
    benchmarkEntries.removeWhere((entry) => indicators.contains(entry.key));

    // Add remaining indicators up to a total of 6
    for (var indicator in benchmarkEntries.reversed.take(6 - indicators.length)) {
      indicators.add(indicator.key);
    }

    print("Impact Chart Indicators: ${indicators.toString()}");
    return indicators;
  }

  Map<String, dynamic> toMap() => {
        'companyBenchmarks': companyBenchmarks,
        'ceoBenchmarks': ceoBenchmarks,
        'cSuiteBenchmarks': cSuiteBenchmarks,
        'employeeBenchmarks': employeeBenchmarks,
        'diffScores': diffScores,
        'nCeoFinished': nCeoFinished,
        'nCSuiteFinished': nCSuiteFinished,
        'nEmployeeFinished': nEmployeeFinished,
        'nSurveys': nSurveys,
        'nStarted': nStarted,
        'nSubmitted': nSubmitted,
        'surveyName': surveyName,
        'notEnoughData': unableToCalculate,
      };

  void printData() {
    print('SurveyMetric Data:');
    print('Survey Name: $surveyName');
    print('Not Enough Data: $unableToCalculate');
    print('Number of Surveys Finished:');
    print('  CEO: $nCeoFinished');
    print('  C-Suite: $nCSuiteFinished');
    print('  Employees: $nEmployeeFinished');
    print('  Total Surveys: $nSurveys');
    print('  Surveys Started: $nStarted');

    print('\nBenchmarks:');
    print('  CEO Benchmarks:');
    ceoBenchmarks.forEach((key, value) {
      print('    $key: $value');
    });
    print('  C-Suite Benchmarks:');
    cSuiteBenchmarks.forEach((key, value) {
      print('    $key: $value');
    });
    print('  Employee Benchmarks:');
    employeeBenchmarks.forEach((key, value) {
      print('    $key: $value');
    });
    print('  Company Benchmarks:');
    companyBenchmarks.forEach((key, value) {
      print('    $key: $value');
    });

    print('\nDifference Scores:');
    diffScores.forEach((key, value) {
      print('  $key: $value');
    });
  }
}

class MetricsData {
  Map<String, SurveyMetric> allSurveyMetrics; // Contains all old survey Data

  MetricsData._internal({
    required this.allSurveyMetrics,
  });

  // Singleton instance
  static final MetricsData _instance = MetricsData._internal(
    allSurveyMetrics: {},
  );

  factory MetricsData() {
    return _instance;
  }

  void addSurveyData(SurveyMetric surveyMetric) {
    allSurveyMetrics[surveyMetric.surveyName] = surveyMetric;
  }

  SurveyMetric getSurveyMetric(String surveyName) {
    return allSurveyMetrics[surveyName]!;
  }

  void printAllSurveyData() {
    allSurveyMetrics.forEach((key, value) {
      print('Survey Name: $key');
      print('Survey Data: ${value.toMap()}');
      print('-----------------------');
    });
  }

  void printSurveyData(String surveyName) {
    print('Survey Data: ${allSurveyMetrics[surveyName]?.toMap()}');
  }
}
