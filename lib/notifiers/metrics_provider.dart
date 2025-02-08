// Create a class for individual survey metrics
class SurveyMetric {
  final Map<String, double> ceoBenchmarks;
  final Map<String, double> cSuiteBenchmarks;
  final Map<String, double> employeeBenchmarks;
  final double nCeoFinished;
  final double nCSuiteFinished;
  final double nEmployeeFinished;
  final double nSurveys;
  final double nStarted;
  final String surveyName;

  SurveyMetric({
    required this.ceoBenchmarks,
    required this.cSuiteBenchmarks,
    required this.employeeBenchmarks,
    required this.nCeoFinished,
    required this.nCSuiteFinished,
    required this.nEmployeeFinished,
    required this.nSurveys,
    required this.nStarted,
    required this.surveyName,
  });

  factory SurveyMetric.fromMap(Map<String, dynamic> map) {
    return SurveyMetric(
      ceoBenchmarks: Map<String, double>.from(map['ceoBenchmarks'] ?? {}),
      cSuiteBenchmarks: Map<String, double>.from(map['cSuiteBenchmarks'] ?? {}),
      employeeBenchmarks: Map<String, double>.from(map['employeeBenchmarks'] ?? {}),
      nCeoFinished: (map['nCeoFinished'] ?? 0.0).toDouble(),
      nEmployeeFinished: (map['nEmployeeFinished'] ?? 0.0).toDouble(),
      nCSuiteFinished: (map['nCSuiteFinished'] ?? 0.0).toDouble(),
      nSurveys: (map['nSurveys'] ?? 0).toDouble(),
      nStarted: (map['nStarted'] ?? 0).toDouble(),
      surveyName: map['surveyName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'ceoBenchmarks': ceoBenchmarks,
        'cSuiteBenchmarks': cSuiteBenchmarks,
        'employeeBenchmarks': employeeBenchmarks,
        'nCeoFinished': nCeoFinished,
        'nCSuiteFinished': nCSuiteFinished,
        'nEmployeeFinished': nEmployeeFinished,
        'nSurveys': nSurveys,
        'nStarted': nStarted,
        'surveyName': surveyName,
      };
}

class MetricsData {
  Map<String, SurveyMetric> oldSurveyMetrics; // Contains all old survey Data
  SurveyMetric? latestSurveyData; // Contains latest Survey Data that could be live.
  String latestSurveyName;

  MetricsData._internal({
    required this.oldSurveyMetrics,
    required this.latestSurveyData,
    required this.latestSurveyName,
  });

  // Singleton instance
  static final MetricsData _instance = MetricsData._internal(
    oldSurveyMetrics: {},
    latestSurveyData: null,
    latestSurveyName: '',
  );

  factory MetricsData() {
    return _instance;
  }

  void addSurveyData(SurveyMetric surveyMetric) {
    oldSurveyMetrics[surveyMetric.surveyName] = surveyMetric;
  }

  void setLatestSurveyName(String latestSurveyDocName) {
    latestSurveyName = latestSurveyDocName;
  }

  void printAllSurveyData() {
    oldSurveyMetrics.forEach((key, value) {
      print('Survey Name: $key');
      print('Survey Data: ${value.toMap()}');
      print('-----------------------');
    });
  }
}
