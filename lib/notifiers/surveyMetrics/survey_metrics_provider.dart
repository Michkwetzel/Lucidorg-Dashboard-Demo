import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/notifiers/loading/loadingNotifer.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';
import 'package:platform_front/notifiers/userProfileData/userProfileData.dart';

class MetricsDataState {
  SurveyMetric surveyMetric;
  bool loading;
  bool noSurveyData;
  bool notEnoughData;
  bool error;

  MetricsDataState({required this.surveyMetric, this.loading = false, this.noSurveyData = true, this.notEnoughData = true, this.error = false});

  factory MetricsDataState.empty() {
    return MetricsDataState(surveyMetric: SurveyMetric.empty());
  }

  MetricsDataState copyWith({SurveyMetric? surveyMetric, bool? loading, bool? noSurveyData, bool? error, bool? notEnoughData}) {
    return MetricsDataState(
        surveyMetric: surveyMetric ?? this.surveyMetric,
        loading: loading ?? this.loading,
        noSurveyData: noSurveyData ?? this.noSurveyData,
        error: error ?? this.error,
        notEnoughData: notEnoughData ?? this.notEnoughData);
  }
}

class MetricsDataProvider extends StateNotifier<MetricsDataState> {
  MetricsDataProvider({required this.userProfileData, required this.loadingNotifier}) : super(MetricsDataState.empty());

  UserProfileDataNotifier userProfileData;
  Loadingnotifier loadingNotifier;
  Logger logger = Logger('SurveyMetricsProvider');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  MetricsData globalMetricsData = MetricsData();

  bool get notEnoughData => state.surveyMetric.notEnoughData;

  void setSurveyMetrics(SurveyMetric surveyMetrics) {
    state.surveyMetric = surveyMetrics;
  }

  bool checkIfSurveyExists() {
    if (userProfileData.latestSurveyDocName == null) {
      print('No Survey');
      state = state.copyWith(noSurveyData: true);
      return false;
    } else {
      print('Survey found');
      state = state.copyWith(noSurveyData: false);
      return true;
    }
  }

  void checkifEnoughData() {
    if (state.surveyMetric.notEnoughData) {
      print('Not enough Data');
      state = state.copyWith(notEnoughData: true);
    } else {
      print('Enough Data');

      state = state.copyWith(notEnoughData: false);
    }
  }

  Future<void> getSurveyData(String companyUID) async {
    try {
      state = state.copyWith(loading: true);
      logger.info('Getting Survey Data for company $companyUID');

      final data = await _firestore.collection('surveyMetrics').doc(companyUID).get();

      final allSurveyNames = List<String>.from(data.data()?['allSurveyNames'] ?? []);
      print(allSurveyNames);

      if (allSurveyNames.isEmpty) {
        print('No surveyData');
        // Load Default Survey metrics
        state = state.copyWith(noSurveyData: true, loading: false, surveyMetric: SurveyMetric.loadDefaultValues());
        state.surveyMetric.printData();
        return;
      }

      for (final surveyName in allSurveyNames) {
        print(surveyName);
        final metricsDoc = await _firestore.collection('surveyMetrics/$companyUID/$surveyName').doc('metrics').get();
        final participationDoc = await _firestore.collection('surveyMetrics/$companyUID/$surveyName').doc('participationStats').get();

        final metricsData = metricsDoc.data() as Map<String, dynamic>;
        final participationData = participationDoc.data() as Map<String, dynamic>;

        final SurveyMetric surveyData = SurveyMetric.fromFields(
          cSuiteBenchmarks: (metricsData['cSuiteBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
          ceoBenchmarks: (metricsData['ceoBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
          employeeBenchmarks: (metricsData['employeeBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
          nCeoFinished: (metricsData['nCeoFinished'] as num?)?.toDouble() ?? 0.0,
          nCSuiteFinished: (metricsData['nCSuiteFinished'] as num?)?.toDouble() ?? 0.0,
          nEmployeeFinished: (metricsData['nEmployeeFinished'] as num?)?.toDouble() ?? 0.0,
          nSurveys: (participationData['nSurveys'] as num?)?.toDouble() ?? 0.0,
          nStarted: (participationData['nStarted'] as num?)?.toDouble() ?? 0.0,
          surveyName: surveyName,
        );

        globalMetricsData.addSurveyData(surveyData);
      }
      state = state.copyWith(
          loading: false,
          noSurveyData: false,
          surveyMetric: globalMetricsData.getSurveyMetric(userProfileData.latestSurveyDocName!),
          notEnoughData: globalMetricsData.getSurveyMetric(userProfileData.latestSurveyDocName!).notEnoughData);
      state.surveyMetric.printData();
    } on Exception catch (e) {
      state = state.copyWith(loading: false);
      logger.severe('Error Getting Metrics: $e');
    }
  }
}
