import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/scoreCompare/score_compare_provider.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';
import 'package:platform_front/notifiers/userProfileData/userProfileData.dart';

class MetricsDataState {
  final SurveyMetric surveyMetric;
  final bool loading;
  final bool noSurveyData;
  final bool participationBelow30;
  final bool between30And70;
  final bool dataReady;
  final bool needAll3Departments;
  final bool showPopUp;
  final bool testData;

  MetricsDataState({
    required this.surveyMetric,
    required this.loading,
    required this.noSurveyData,
    required this.participationBelow30,
    required this.between30And70,
    required this.dataReady,
    required this.needAll3Departments,
    required this.showPopUp,
    required this.testData,
  });

  factory MetricsDataState.init() {
    return MetricsDataState(
      surveyMetric: SurveyMetric.loadDefaultValues(),
      needAll3Departments: false,
      noSurveyData: false,
      loading: false,
      participationBelow30: false,
      dataReady: false,
      between30And70: false,
      showPopUp: true,
      testData: false,
    );
  }

  MetricsDataState copyWith({
    SurveyMetric? surveyMetric,
    bool? loading,
    bool? noSurveyData,
    bool? between30And70,
    bool? dataReady,
    bool? participationBelow30,
    bool? needAll3Departments,
    bool? showPopUp,
    bool? testData,
  }) {
    return MetricsDataState(
      surveyMetric: surveyMetric ?? this.surveyMetric,
      loading: loading ?? this.loading,
      noSurveyData: noSurveyData ?? this.noSurveyData,
      participationBelow30: participationBelow30 ?? this.participationBelow30,
      between30And70: between30And70 ?? this.between30And70,
      dataReady: dataReady ?? this.dataReady,
      needAll3Departments: needAll3Departments ?? this.needAll3Departments,
      showPopUp: showPopUp ?? this.showPopUp,
      testData: testData ?? this.testData,
    );
  }
}

class MetricsDataProvider extends StateNotifier<MetricsDataState> {
  MetricsDataProvider({
    required this.userProfileData,
    required this.scoreCompareProvider,
  }) : super(MetricsDataState.init());

  Logger logger = Logger('SurveyMetricsProvider');

  UserProfileDataNotifier userProfileData;
  ScoreCompareProvider scoreCompareProvider;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  MetricsData globalMetricsData = MetricsData();

  void setSurveyMetrics(SurveyMetric surveyMetrics) {
    state = state.copyWith(surveyMetric: surveyMetrics);
  }

  bool getShowPopUp() {
    return state.showPopUp;
  }

  void hidePopUp() {
    state = state.copyWith(showPopUp: false);
  }

  Future<void> getSurveyData() async {
    try {
      state = state.copyWith(loading: true);
      String? companyUID = userProfileData.companyUID;
      if (companyUID == null && userProfileData.permission == Permission.guest) {
        //Test account. Load default values, enable pop up and set top banner to display test dashboard message
        logger.info('Test Dashboard');
        state = state.copyWith(
            loading: false,
            surveyMetric: SurveyMetric.loadDefaultValues(),
            noSurveyData: false,
            needAll3Departments: false,
            between30And70: false,
            participationBelow30: false,
            showPopUp: false,
            testData: true);
        scoreCompareProvider.initLoad();
      } else {
        logger.info('Getting Survey Data for company $companyUID');
        final companyDoc = await _firestore.collection('surveyMetrics').doc(companyUID).get();
        final allSurveyNames = List<String>.from(companyDoc.data()?['allSurveyNames'] ?? []);
        logger.info('All survey names: $allSurveyNames');

        if (allSurveyNames.isEmpty) {
          print('No surveyData');
          state = state.copyWith(
            loading: false,
            surveyMetric: SurveyMetric.loadDefaultValues(),
            noSurveyData: true,
            needAll3Departments: false,
            between30And70: false,
            participationBelow30: false,
            showPopUp: true,
          );
          return;
        }

        // Store futures for all get operations
        final futures = <Future<DocumentSnapshot>>[];
        for (final surveyName in allSurveyNames) {
          final metricsRef = _firestore.collection('surveyMetrics/$companyUID/$surveyName').doc('metrics');
          final participationRef = _firestore.collection('surveyMetrics/$companyUID/$surveyName').doc('participationStats');
          futures.add(metricsRef.get());
          futures.add(participationRef.get());
        }

        // Await all futures concurrently
        final snapshots = await Future.wait(futures);

        // Process the snapshots
        for (int i = 0; i < allSurveyNames.length; i++) {
          final surveyName = allSurveyNames[i];
          final metricsData = snapshots[i * 2].data() as Map<String, dynamic>? ?? {};
          final participationData = snapshots[i * 2 + 1].data() as Map<String, dynamic>? ?? {};

          final SurveyMetric surveyData = SurveyMetric.fromStringFields(
            cSuiteBenchmarks: metricsData['cSuiteBenchmarks'],
            ceoBenchmarks: metricsData['ceoBenchmarks'],
            employeeBenchmarks: metricsData['employeeBenchmarks'],
            nCeoFinished: (metricsData['nCeoFinished'] as num?)?.toDouble() ?? 0,
            nCSuiteFinished: (metricsData['nCSuiteFinished'] as num?)?.toDouble() ?? 0,
            nEmployeeFinished: (metricsData['nEmployeeFinished'] as num?)?.toDouble() ?? 0,
            nSurveys: (participationData['nSurveys'] as num?)?.toDouble() ?? 0,
            nStarted: (participationData['nStarted'] as num?)?.toDouble() ?? 0,
            surveyName: surveyName,
          );
          globalMetricsData.addSurveyData(surveyData);
        }

        //Init loading of score/diff compare result section
        scoreCompareProvider.initLoad();

        // Get latest survey
        // Check participation rate and set accordingly
        SurveyMetric latestSurvey = globalMetricsData.getSurveyMetric(userProfileData.latestSurveyDocName!);
        //latestSurvey.printData();
        if (latestSurvey.getSurveyParticipation < 30) {
          print('<30');
          state = state.copyWith(
            loading: false,
            noSurveyData: false,
            participationBelow30: true,
            between30And70: false,
            needAll3Departments: false,
            dataReady: false,
            surveyMetric: SurveyMetric.loadBlurredData(
                nCeoFinished: latestSurvey.nCeoFinished,
                nCSuiteFinished: latestSurvey.nCSuiteFinished,
                nEmployeeFinished: latestSurvey.nEmployeeFinished,
                nStarted: latestSurvey.nStarted,
                nSurveys: latestSurvey.nSurveys,
                surveyName: latestSurvey.surveyDevName),
          );
        } else if (latestSurvey.unableToCalculate) {
          print('Unable to calculate');

          state = state.copyWith(
            loading: false,
            noSurveyData: false,
            participationBelow30: false,
            between30And70: false,
            needAll3Departments: true,
            dataReady: false,
            surveyMetric: SurveyMetric.loadBlurredData(
                nCeoFinished: latestSurvey.nCeoFinished,
                nCSuiteFinished: latestSurvey.nCSuiteFinished,
                nEmployeeFinished: latestSurvey.nEmployeeFinished,
                nStarted: latestSurvey.nStarted,
                nSurveys: latestSurvey.nSurveys,
                surveyName: latestSurvey.surveyDevName),
          );
        } else if (latestSurvey.getSurveyParticipation < 70) {
          state = state.copyWith(
            loading: false,
            noSurveyData: false,
            participationBelow30: false,
            needAll3Departments: false,
            between30And70: true,
            dataReady: false,
            surveyMetric: latestSurvey,
          );
        } else {
          state = state.copyWith(
            loading: false,
            noSurveyData: false,
            participationBelow30: false,
            needAll3Departments: false,
            between30And70: false,
            dataReady: true,
            surveyMetric: latestSurvey,
          );
        }
        // at this point we have the state of the latest survey. and can upadte our UI accordingly
      }
    } catch (e) {
      logger.severe('Error getting survey data: $e');
      state = state.copyWith(loading: false, dataReady: true);
    }
  }

  bool getNoSurveyData() {
    return state.noSurveyData;
  }
}
