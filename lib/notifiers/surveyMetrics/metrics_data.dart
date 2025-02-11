// Create a class for individual survey metrics
import 'dart:math';

class SurveyMetric {
  final Map<String, double> ceoBenchmarks;
  final Map<String, double> cSuiteBenchmarks;
  final Map<String, double> employeeBenchmarks;
  final Map<String, double> companyBenchmarks;
  final Map<String, double> diffScores;
  final int nCeoFinished;
  final int nCSuiteFinished;
  final int nEmployeeFinished;
  final int nSurveys;
  final int nStarted;
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

  factory SurveyMetric.loadDefaultValues() {
    Map<String, dynamic> map = {
      'companyBenchmarks': {
        'align': 0.5843833333333334,
        'meetingEfficacy': 0.7222,
        'leadership': 0.5751833333333334,
        'index': 0.57035,
        'workforce': 0.56175,
        'alignedOrgStruct': 0.7221666666666667,
        'alignedTech': 0.75,
        'growthAlign': 0.6667166666666665,
        'collabKPIs': 0.5277999999999999,
        'crossAcc': 0.5833833333333333,
        'crossComms': 0.33335,
        'people': 0.5527666666666666,
        'engagedCommunity': 0.6667166666666665,
        'collabProcess': 0.5277999999999999,
        'process': 0.6197666666666667,
        'general': 0.4800166666666667,
        'purposeDriven': 0.6666333333333333,
        'operations': 0.6055833333333333,
        'empoweredLeadership': 0.5277833333333333
      },
      'ceoBenchmarks': {
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
      },
      'cSuiteBenchmarks': {
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
      },
      'employeeBenchmarks': {
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
      },
      'diffScores': {
        'align': 0.008499999999999952,
        'meetingEfficacy': 0.5,
        'leadership': 0.0898000000000001,
        'index': 0.07279999999999998,
        'workforce': 0.06110000000000004,
        'alignedOrgStruct': 0.25,
        'alignedTech': 0.4444,
        'growthAlign': 0.27780000000000005,
        'collabKPIs': 0.05559999999999998,
        'crossAcc': 0.11109999999999998,
        'crossComms': 0.33330000000000004,
        'people': 0.06389999999999996,
        'engagedCommunity': 0.27780000000000005,
        'collabProcess': 0.05559999999999998,
        'process': 0.19879999999999998,
        'general': 0.08000000000000002,
        'purposeDriven': 0.27780000000000005,
        'operations': 0.1199,
        'empoweredLeadership': 0.25000000000000006
      },
      'nCeoFinished': 1,
      'nCSuiteFinished': 2,
      'nEmployeeFinished': 3,
      'nSurveys': 1,
      'nStarted': 0,
      'surveyName': '2025-02-10T07-57-27'
    };

    return SurveyMetric(
        companyBenchmarks: (map['companyBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
        ceoBenchmarks: (map['ceoBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
        cSuiteBenchmarks: (map['cSuiteBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
        employeeBenchmarks: (map['employeeBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
        diffScores: (map['diffScores'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
        nCeoFinished: 1, // Default to 0 if null
        nCSuiteFinished: 4,
        nEmployeeFinished: 12,
        nSurveys: 20,
        nStarted: 15,
        surveyName: 'Default',
        notEnoughData: false);
  }

  factory SurveyMetric.fromFields({
    required Map<String, double> ceoBenchmarks,
    required Map<String, double> cSuiteBenchmarks,
    required Map<String, double> employeeBenchmarks,
    required int nCeoFinished,
    required int nCSuiteFinished,
    required int nEmployeeFinished,
    required int nSurveys,
    required int nStarted,
    required String surveyName,
  }) {
    //Calculate combined company benchmark
    Map<String, double> companyBenchmarks = {};
    Map<String, double> diffScores = {};

    if (employeeBenchmarks.isNotEmpty && cSuiteBenchmarks.isNotEmpty && ceoBenchmarks.isNotEmpty) {
      for (final key in ceoBenchmarks.keys) {
        companyBenchmarks[key] = ((((ceoBenchmarks[key]! * nCeoFinished) + (cSuiteBenchmarks[key]! * nCSuiteFinished) + (employeeBenchmarks[key]! * nEmployeeFinished)) /
                        (nCeoFinished + nCSuiteFinished + nEmployeeFinished)) *
                    10)
                .roundToDouble() /
            10;
      }
      for (final key in ceoBenchmarks.keys) {
        double value1 = (ceoBenchmarks[key]! - cSuiteBenchmarks[key]!).abs();
        double value2 = (ceoBenchmarks[key]! - employeeBenchmarks[key]!).abs();
        double value3 = (cSuiteBenchmarks[key]! - employeeBenchmarks[key]!).abs();
        diffScores[key] = (max(value1, max(value2, value3)) * 10).roundToDouble() / 10;
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
