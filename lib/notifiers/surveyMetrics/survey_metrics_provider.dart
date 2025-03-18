import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/assessment/currentAssessment/currentAssessmentEmailProvider.dart';
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
  final bool canSendNewAssessment;

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
    required this.canSendNewAssessment,
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
      canSendNewAssessment: true,
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
    bool? canSendNewAssessment,
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
      canSendNewAssessment: canSendNewAssessment ?? this.canSendNewAssessment,
    );
  }
}

class MetricsDataProvider extends StateNotifier<MetricsDataState> {
  MetricsDataProvider({
    required this.userProfileData,
    required this.scoreCompareProvider,
    required this.currentAssessmentProvider,
  }) : super(MetricsDataState.init());

  Logger logger = Logger('SurveyMetricsProvider');

  UserProfileDataNotifier userProfileData;
  ScoreCompareNotifier scoreCompareProvider;
  CurrentEmailListNotifier currentAssessmentProvider;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  MetricsData globalMetricsData = MetricsData();

  SurveyMetric getCurrentSurveyMetric() {
    return state.surveyMetric;
  }

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
            testData: true,
            canSendNewAssessment: true);
        scoreCompareProvider.initLoad();
        return;
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
              canSendNewAssessment: true);
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
        bool canSendAssessment = isOneMonthPassed(latestSurvey.surveyDevName)[0];
        currentAssessmentProvider.getCurrentEmails();
        //latestSurvey.printData();
        print("hi5");
        if (latestSurvey.getSurveyParticipation < 30) {
          print('<30');
          state = state.copyWith(
            loading: false,
            canSendNewAssessment: canSendAssessment,
            noSurveyData: false,
            participationBelow30: true,
            between30And70: false,
            needAll3Departments: false,
            dataReady: false,
            surveyMetric: SurveyMetric.loadBlurredData(
                surveyStartDate: processSurveyDate(latestSurvey.surveyDevName)[0],
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
            canSendNewAssessment: canSendAssessment,
            noSurveyData: false,
            participationBelow30: false,
            between30And70: false,
            needAll3Departments: true,
            dataReady: false,
            surveyMetric: SurveyMetric.loadBlurredData(
                surveyStartDate: processSurveyDate(latestSurvey.surveyDevName)[0],
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
            canSendNewAssessment: canSendAssessment,
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
            canSendNewAssessment: canSendAssessment,
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

  List<String> processSurveyDate(String dateString) {
    try {
      // Split into date and time parts
      List<String> parts = dateString.split('T');
      if (parts.length != 2) {
        // If we can't split properly, try to parse the string directly
        throw FormatException('Invalid date format');
      }

      String datePart = parts[0]; // This is already in YYYY-MM-DD format
      String timePart = parts[1].replaceAll('-', ':'); // Convert time separators

      // Combine date and time
      String normalizedDate = '$datePart $timePart';

      // Parse the normalized date string
      DateTime dateObj = DateTime.parse(normalizedDate);

      // Format to "17 Feb 2025"
      String formatted = DateFormat('dd MMM yyyy').format(dateObj);

      // Calculate date 4 months in future
      DateTime futureDate = DateTime(
        dateObj.year,
        dateObj.month + 4,
        dateObj.day,
        dateObj.hour,
        dateObj.minute,
        dateObj.second,
      );
      String futureFormatted = DateFormat('dd MMM yyyy').format(futureDate);
      print('Formatted: $formatted');

      return [formatted, futureFormatted];
    } catch (e) {
      // Handle parsing errors by returning a default or current date
      DateTime now = DateTime.now();
      String formatted = DateFormat('dd MMM yyyy').format(now);
      DateTime futureDate = DateTime(now.year, now.month + 4, now.day);
      String futureFormatted = DateFormat('dd MMM yyyy').format(futureDate);

      print('Error processing date: $dateString'); // For debugging
      return [formatted, futureFormatted];
    }
  }

  List<dynamic> isOneMonthPassed(String dateString) {
    // Parse the date string
    List<String> parts = dateString.split('T');

    String datePart = parts[0]; // "2012-02-27"
    String timePart = parts[1];
    String newTimePart = timePart.replaceAll("-", ":");
    String newDateString = "$datePart $newTimePart";

    DateTime assessmentDate = DateTime.parse(newDateString);

    // Get current date
    final currentDate = DateTime.now();

    // Calculate one month after the assessment date
    DateTime oneMonthAfter;

    // Handle month rollover properly
    if (assessmentDate.month == 12) {
      // If December, move to January of next year
      oneMonthAfter = DateTime(assessmentDate.year + 1, 1, assessmentDate.day <= DateTime(assessmentDate.year + 1, 1 + 1, 0).day ? assessmentDate.day : DateTime(assessmentDate.year + 1, 1 + 1, 0).day,
          assessmentDate.hour, assessmentDate.minute, assessmentDate.second);
    } else {
      // For other months
      oneMonthAfter = DateTime(
          assessmentDate.year,
          assessmentDate.month + 1,
          assessmentDate.day <= DateTime(assessmentDate.year, assessmentDate.month + 2, 0).day ? assessmentDate.day : DateTime(assessmentDate.year, assessmentDate.month + 2, 0).day,
          assessmentDate.hour,
          assessmentDate.minute,
          assessmentDate.second);
    }

    // Format the date as "20 March 2025"
    List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    String formattedDate = "${oneMonthAfter.day} ${months[oneMonthAfter.month - 1]} ${oneMonthAfter.year}";

    // Check if current date is after one month since assessment
    bool isPassed = currentDate.isAfter(oneMonthAfter);

    // Return both the boolean result and the formatted date
    return [isPassed, formattedDate];
  }

  bool getNoSurveyData() {
    return state.noSurveyData;
  }

  void resetToInitialState() {
    state = MetricsDataState.init();
  }
}
