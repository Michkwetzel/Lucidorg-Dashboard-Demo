import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';
import 'package:platform_front/notifiers/userProfileData/userProfileData.dart';

class MetricsDataState {
  SurveyMetric surveyMetric;
  bool finishedLoading;
  bool noData;
  bool notEnoughData;

  MetricsDataState({required this.surveyMetric, this.finishedLoading = false, this.noData = true, this.notEnoughData = true});

  factory MetricsDataState.empty() {
    return MetricsDataState(surveyMetric: SurveyMetric.empty());
  }

  MetricsDataState copyWith({SurveyMetric? surveyMetric, bool? finishedLoading, bool? noData}) {
    return MetricsDataState(
      surveyMetric: surveyMetric ?? this.surveyMetric,
      finishedLoading: finishedLoading ?? this.finishedLoading,
      noData: noData ?? this.noData,
    );
  }
}

class MetricsDataProvider extends StateNotifier<MetricsDataState> {
  MetricsDataProvider({required this.userProfileData}) : super(MetricsDataState.empty());

  UserProfileDataNotifier userProfileData;
  Logger logger = Logger('SurveyMetricsProvider');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  MetricsData globalMetricsData = MetricsData();

  bool get notEnoughData => state.surveyMetric.notEnoughData;

  void setSurveyMetrics(SurveyMetric surveyMetrics) {
    state.surveyMetric = surveyMetrics;
  }

  Future<void> getSurveyData(String companyUID) async {
    try {
      logger.info('Getting Survey Data for company $companyUID');

      final data = await _firestore.collection('surveyMetrics').doc(companyUID).get();

      final allSurveyNames = List<String>.from(data.data()?['allSurveyNames'] ?? []);
      print(allSurveyNames);

      if (allSurveyNames.isEmpty) {
        print('No surveyData');
        state = state.copyWith(noData: true);
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
      state = state.copyWith(finishedLoading: true, noData: false, surveyMetric: globalMetricsData.getSurveyMetric(userProfileData.latestSurveyDocName!));
      state.surveyMetric.printData();
      globalMetricsData.printAllSurveyData();

    } on Exception catch (e) {
      logger.severe('Error Getting Metrics: $e');
    }
  }
}
