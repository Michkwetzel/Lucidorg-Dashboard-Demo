// Create a class for individual survey metrics
import 'dart:math';

class SurveyMetric {
  final Map<String, double> ceoBenchmarks;
  final Map<String, double> cSuiteBenchmarks;
  final Map<String, double> employeeBenchmarks;
  final Map<String, double> companyBenchmarks;
  final Map<String, double> diffScores;
  final double nCeoFinished;
  final double nCSuiteFinished;
  final double nEmployeeFinished;
  final double nSurveys;
  final double nStarted;
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
      surveyName: '',
      notEnoughData: true,
    );
  }

  factory SurveyMetric.fromFields({
    required Map<String, double> ceoBenchmarks,
    required Map<String, double> cSuiteBenchmarks,
    required Map<String, double> employeeBenchmarks,
    required double nCeoFinished,
    required double nCSuiteFinished,
    required double nEmployeeFinished,
    required double nSurveys,
    required double nStarted,
    required String surveyName,
  }) {
    //Calculate combined company benchmark
    Map<String, double> companyBenchmarks = {};
    Map<String, double> diffScores = {};

    if (employeeBenchmarks.isNotEmpty && cSuiteBenchmarks.isNotEmpty && ceoBenchmarks.isNotEmpty) {
      for (final key in ceoBenchmarks.keys) {
        companyBenchmarks[key] =
            ((ceoBenchmarks[key]! * nCeoFinished) + (cSuiteBenchmarks[key]! * nCSuiteFinished) + (employeeBenchmarks[key]! * nEmployeeFinished)) / (nCeoFinished + nCSuiteFinished + nEmployeeFinished);
      }
      for (final key in ceoBenchmarks.keys) {
        double value1 = (ceoBenchmarks[key]! - cSuiteBenchmarks[key]!).abs();
        double value2 = (ceoBenchmarks[key]! - employeeBenchmarks[key]!).abs();
        double value3 = (cSuiteBenchmarks[key]! - employeeBenchmarks[key]!).abs();
        diffScores[key] = max(value1, max(value2, value3));
      }
    }

    return SurveyMetric(
      companyBenchmarks: companyBenchmarks,
      ceoBenchmarks: ceoBenchmarks,
      cSuiteBenchmarks: cSuiteBenchmarks,
      employeeBenchmarks: employeeBenchmarks,
      diffScores: diffScores,
      nCeoFinished: nCeoFinished,
      nCSuiteFinished: nCSuiteFinished,
      nEmployeeFinished: nEmployeeFinished,
      nSurveys: nSurveys,
      nStarted: nStarted,
      surveyName: surveyName,
      notEnoughData: companyBenchmarks.isEmpty ? true : false,
    );
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
        'surveyName': surveyName,
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
