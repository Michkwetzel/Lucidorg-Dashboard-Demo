import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SurveyMetricsState {
  final Map<String, double> ceoBenchmarks;
  final Map<String, double> cSuiteBenchmarks;
  final Map<String, double> employeeBenchmarks;
  final int nCeoFinished;
  final int nCSuiteFinished;
  final int nEmployeeFinished;
  final int nFinished;
  final int nStarted;
  final int nSurveys;

  // Private constructor
  SurveyMetricsState._internal({
    required this.ceoBenchmarks,
    required this.cSuiteBenchmarks,
    required this.employeeBenchmarks,
    required this.nCeoFinished,
    required this.nCSuiteFinished,
    required this.nEmployeeFinished,
    required this.nFinished,
    required this.nStarted,
    required this.nSurveys,
  });

  // Factory constructor for default state
  factory SurveyMetricsState.defaultState() {
    return SurveyMetricsState._internal(
      ceoBenchmarks: {},
      cSuiteBenchmarks: {},
      employeeBenchmarks: {},
      nCeoFinished: 0,
      nCSuiteFinished: 0,
      nEmployeeFinished: 0,
      nFinished: 0,
      nStarted: 0,
      nSurveys: 0,
    );
  }

  factory SurveyMetricsState.fromDocs(DocumentSnapshot metricsDoc, DocumentSnapshot participationDoc) {
    final metricsData = metricsDoc.data() as Map<String, dynamic>;
    final participationData = participationDoc.data() as Map<String, dynamic>;

    Map<String, double> ceoBenchmarks = metricsData['ceoBenchmarks'] ?? {};
    Map<String, double> cSuiteBenchmarks = metricsData['cSuiteBenchmarks'] ?? {};
    Map<String, double> employeeBenchmarks = metricsData['employeeBenchmarks'] ?? {};

    int nCeoFinished = participationData['nCeoFinished'] ?? 0;
    int nCSuiteFinished = participationData['nCSuiteFinished'] ?? 0;
    int nEmployeeFinished = participationData['nEmployeeFinished'] ?? 0;

    int nFinished = nCeoFinished + nCSuiteFinished + nEmployeeFinished;

    int nStarted = participationData['nStarted'] ?? 0;
    int nSurveys = participationData['nSurveys'] ?? 0;

    return SurveyMetricsState._internal(
      ceoBenchmarks: ceoBenchmarks,
      cSuiteBenchmarks: cSuiteBenchmarks,
      employeeBenchmarks: employeeBenchmarks,
      nCeoFinished: nCeoFinished,
      nCSuiteFinished: nCSuiteFinished,
      nEmployeeFinished: nEmployeeFinished,
      nFinished: nFinished,
      nStarted: nStarted,
      nSurveys: nSurveys,
    );
  }
}

class SurveyMetricsProvider extends StateNotifier<SurveyMetricsState> {
  SurveyMetricsProvider() : super(SurveyMetricsState.defaultState());

  void updateSurveyMetrics(DocumentSnapshot metricsDoc, DocumentSnapshot participationDoc) {
    state = SurveyMetricsState.fromDocs(metricsDoc, participationDoc);
  }
}
