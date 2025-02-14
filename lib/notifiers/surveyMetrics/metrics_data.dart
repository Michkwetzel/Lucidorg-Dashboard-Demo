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
  final bool notEnoughData;

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
    required this.notEnoughData,
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
      notEnoughData: true,
    );
  }

  factory SurveyMetric.loadDefaultValues() {
    Map<String, double> ceoBenchmarks = {
      'align': 0.5828,
      'meetingEfficacy': 1,
      'leadership': 0.5287,
      'companyIndex': 0.5795,
      'workforce': 0.5558,
      'orgAlign': 0.8333,
      'alignedTech': 1,
      'growthAlign': 0.6667,
      'collabKPIs': 0.5,
      'crossFuncAcc': 0.6667,
      'crossFuncComms': 0.1667,
      'people': 0.5738,
      'engagedCommunity': 0.6667,
      'collabProcesses': 0.5,
      'process': 0.73,
      'general': 0.44,
      'purposeDriven': 0.8333,
      'operations': 0.6711,
      'empoweredLeadership': 0.3333
    };
    Map<String, double> cSuiteBenchmarks = {
      'purposeDriven': 0.75,
      'meetingEfficacy': 0.9166,
      'companyIndex': 0.6122,
      'leadership': 0.6185,
      'general': 0.52,
      'engagedCommunity': 0.8334,
      'collabKPIs': 0.5,
      'process': 0.6975,
      'people': 0.5869,
      'collabProcesses': 0.5,
      'empoweredLeadership': 0.5833,
      'alignedTech': 0.9166,
      'crossFuncAcc': 0.5834,
      'crossFuncComms': 0.1667,
      'growthAlign': 0.8334,
      'orgAlign': 0.5833,
      'align': 0.5898,
      'operations': 0.6544,
      'workforce': 0.5996
    };
    Map<String, double> employeeBenchmarks = {
      'companyIndex': 0.5394,
      'meetingEfficacy': 0.5,
      'growthAlign': 0.5556,
      'collabProcesses': 0.5556,
      'engagedCommunity': 0.5556,
      'operations': 0.5512,
      'general': 0.4667,
      'crossFuncAcc': 0.5556,
      'empoweredLeadership': 0.5556,
      'align': 0.5813,
      'workforce': 0.5385,
      'process': 0.5312,
      'crossFuncComms': 0.5,
      'alignedTech': 0.5556,
      'purposeDriven': 0.5555,
      'orgAlign': 0.7777,
      'leadership': 0.5618,
      'people': 0.523,
      'collabKPIs': 0.5556
    };

    double nCeoFinished = 1;
    double nCSuiteFinished = 4;
    double nEmployeeFinished = 12;
    double nSurveys = 20;
    double nStarted = 18;
    String surveyName = 'Default';

    return SurveyMetric.fromStringFields(
        ceoBenchmarks: ceoBenchmarks,
        cSuiteBenchmarks: cSuiteBenchmarks,
        employeeBenchmarks: employeeBenchmarks,
        nCeoFinished: nCeoFinished,
        nCSuiteFinished: nCSuiteFinished,
        nEmployeeFinished: nEmployeeFinished,
        nSurveys: nSurveys,
        nStarted: nStarted,
        surveyName: surveyName);
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
      notEnoughData: companyBenchmarksMap.isEmpty ? true : false,
    );
  }

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
    Map<Indicator, double> removeIndicators(Map<Indicator, double> map) {
      map.remove(Indicator.align);
      map.remove(Indicator.people);
      map.remove(Indicator.process);
      map.remove(Indicator.leadership);
      map.remove(Indicator.companyIndex);
      map.remove(Indicator.general);
      map.remove(Indicator.workforce);
      map.remove(Indicator.operations);
      return map;
    }

    switch (mapName) {
      case 'ceoBenchmarks':
        return removeIndicators(cSuiteBenchmarks);
      case 'cSuiteBenchmarks':
        return removeIndicators(cSuiteBenchmarks);
      case 'employeeBenchmarks':
        return removeIndicators(employeeBenchmarks);
      default:
        return {};
    }
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
        'notEnoughData': notEnoughData,
      };

  void printData() {
    print('SurveyMetric Data:');
    print('Survey Name: $surveyName');
    print('Not Enough Data: $notEnoughData');
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
