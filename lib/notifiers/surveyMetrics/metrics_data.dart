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
      'index': 0.5795,
      'workforce': 0.5558,
      'alignedOrgStruct': 0.8333,
      'alignedTech': 1,
      'growthAlign': 0.6667,
      'collabKPIs': 0.5,
      'crossAcc': 0.6667,
      'crossComms': 0.1667,
      'people': 0.5738,
      'engagedCommunity': 0.6667,
      'collabProcess': 0.5,
      'process': 0.73,
      'general': 0.44,
      'purposeDriven': 0.8333,
      'operations': 0.6711,
      'empoweredLeadership': 0.3333
    };
    Map<String, double> cSuiteBenchmarks = {
      'purposeDriven': 0.75,
      'meetingEfficacy': 0.9166,
      'index': 0.6122,
      'leadership': 0.6185,
      'general': 0.52,
      'engagedCommunity': 0.8334,
      'collabKPIs': 0.5,
      'process': 0.6975,
      'people': 0.5869,
      'collabProcess': 0.5,
      'empoweredLeadership': 0.5833,
      'alignedTech': 0.9166,
      'crossAcc': 0.5834,
      'crossComms': 0.1667,
      'growthAlign': 0.8334,
      'alignedOrgStruct': 0.5833,
      'align': 0.5898,
      'operations': 0.6544,
      'workforce': 0.5996
    };
    Map<String, double> employeeBenchmarks = {
      'index': 0.5394,
      'meetingEfficacy': 0.5,
      'growthAlign': 0.5556,
      'collabProcess': 0.5556,
      'engagedCommunity': 0.5556,
      'operations': 0.5512,
      'general': 0.4667,
      'crossAcc': 0.5556,
      'empoweredLeadership': 0.5556,
      'align': 0.5813,
      'workforce': 0.5385,
      'process': 0.5312,
      'crossComms': 0.5,
      'alignedTech': 0.5556,
      'purposeDriven': 0.5555,
      'alignedOrgStruct': 0.7777,
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

    return SurveyMetric.fromFields(
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

  factory SurveyMetric.fromFields({
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
    Map<String, double> companyBenchmarks = {};
    Map<String, double> diffScores = {};

    //Calculate combined company benchmark
    if (employeeBenchmarks.isNotEmpty && cSuiteBenchmarks.isNotEmpty && ceoBenchmarks.isNotEmpty) {
      for (final key in ceoBenchmarks.keys) {
        companyBenchmarks[key] = (((ceoBenchmarks[key]! * nCeoFinished) + (cSuiteBenchmarks[key]! * nCSuiteFinished) + (employeeBenchmarks[key]! * nEmployeeFinished)) /
            (nCeoFinished + nCSuiteFinished + nEmployeeFinished));
      }
      for (final key in ceoBenchmarks.keys) {
        double value1 = (ceoBenchmarks[key]! - cSuiteBenchmarks[key]!).abs();
        double value2 = (ceoBenchmarks[key]! - employeeBenchmarks[key]!).abs();
        double value3 = (cSuiteBenchmarks[key]! - employeeBenchmarks[key]!).abs();
        diffScores[key] = max(value1, max(value2, value3));
      }
    }

    // Convert to percent. from 0.111 to 11.1
    Map<String, double> convertBenchmarks(Map<String, dynamic>? benchmarks) {
      return benchmarks?.map((key, value) {
            final numValue = value as num?;
            return MapEntry(key, numValue != null ? (((numValue.toDouble() * 1000).roundToDouble()) / 10) : 0.0);
          }) ??
          {};
    }

    return SurveyMetric(
      companyBenchmarks: convertBenchmarks(companyBenchmarks),
      ceoBenchmarks: convertBenchmarks(ceoBenchmarks),
      cSuiteBenchmarks: convertBenchmarks(cSuiteBenchmarks),
      employeeBenchmarks: convertBenchmarks(employeeBenchmarks),
      diffScores: convertBenchmarks(diffScores),
      nCeoFinished: nCeoFinished,
      nCSuiteFinished: nCSuiteFinished,
      nEmployeeFinished: nEmployeeFinished,
      nSurveys: nSurveys,
      nStarted: nStarted,
      nSubmitted: nCeoFinished + nCSuiteFinished + nEmployeeFinished,
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
