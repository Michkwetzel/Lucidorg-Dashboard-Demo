import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class ScoreCompareState {
  // Data to display
  final SurveyMetric survey1Data;
  final SurveyMetric survey2Data;
  final Map<Indicator, double> diffChange;
  final Map<Indicator, double> scoreChange;
  final List<Map<Indicator, double>> topDiffImprove;
  final List<Map<Indicator, double>> topDiffDecline;
  final List<Map<Indicator, double>> topScoreImprove;
  final List<Map<Indicator, double>> topScoreDecline;

  // Logic and Data store
  final bool blur;
  final Map<String, SurveyMetric> allComparableSurveys; //Here they have the correct name.

  ScoreCompareState({
    required this.topDiffImprove,
    required this.topDiffDecline,
    required this.topScoreImprove,
    required this.topScoreDecline,
    required this.survey1Data,
    required this.survey2Data,
    required this.diffChange,
    required this.scoreChange,
    required this.blur,
    required this.allComparableSurveys,
  });

  ScoreCompareState copyWith({
    bool? blur,
    SurveyMetric? survey1Data,
    SurveyMetric? survey2Data,
    Map<Indicator, double>? diffChange,
    Map<Indicator, double>? scoreChange,
    Map<String, SurveyMetric>? allComparableSurveys,
    List<Map<Indicator, double>>? topDiffImprove,
    List<Map<Indicator, double>>? topDiffDecline,
    List<Map<Indicator, double>>? topScoreImprove,
    List<Map<Indicator, double>>? topScoreDecline,
  }) {
    return ScoreCompareState(
      blur: blur ?? this.blur,
      survey1Data: survey1Data ?? this.survey1Data,
      survey2Data: survey2Data ?? this.survey2Data,
      diffChange: diffChange ?? this.diffChange,
      scoreChange: scoreChange ?? this.scoreChange,
      allComparableSurveys: allComparableSurveys ?? this.allComparableSurveys,
      topDiffDecline: topDiffDecline ?? this.topDiffDecline,
      topDiffImprove: topDiffImprove ?? this.topDiffImprove,
      topScoreDecline: topScoreDecline ?? this.topScoreDecline,
      topScoreImprove: topScoreImprove ?? this.topScoreImprove,
    );
  }

  factory ScoreCompareState.initial() {
    SurveyMetric survey1 = SurveyMetric.loadBlurredData(surveyStartDate: '25 March 2025');
    SurveyMetric survey2 = SurveyMetric.loadDefaultValues();

    return ScoreCompareState(
        blur: true,
        survey1Data: survey1,
        survey2Data: survey2,
        diffChange: {},
        scoreChange: {},
        allComparableSurveys: {'Q1 2025': survey1, 'Q2 2025': survey2},
        topDiffImprove: [],
        topDiffDecline: [],
        topScoreImprove: [],
        topScoreDecline: []);
  }
}

class ScoreCompareNotifier extends StateNotifier<ScoreCompareState> {
  ScoreCompareNotifier()
      //Set Default empty state
      : super(ScoreCompareState.initial()) {
    calculateChange();
  }

  Logger logger = Logger('ScoreCompareNotifier');

  void calculateChange() {
    Map<Indicator, double> diffChange = {};
    Map<Indicator, double> scoreChange = {};

    Map<Indicator, double> companyBenchmark1 = state.survey1Data.companyBenchmarks;
    Map<Indicator, double> companyBenchmark2 = state.survey2Data.companyBenchmarks;

    Map<Indicator, double> companyDiff1 = state.survey1Data.diffScores;
    Map<Indicator, double> companyDiff2 = state.survey2Data.diffScores;

    List<Indicator> indicators = justIndicators();

    companyBenchmark1.forEach((indicator, value) {
      if (indicators.contains(indicator)) {
        scoreChange[indicator] = companyBenchmark2[indicator]! - value;
        diffChange[indicator] = companyDiff2[indicator]! - companyDiff1[indicator]!;
      }
    });

    List<MapEntry<Indicator, double>> sortedScoreChanges = scoreChange.entries.toList()..sort((a, b) => b.value.compareTo(a.value)); // Sort descendin
    List<Map<Indicator, double>> topScoreChanges = sortedScoreChanges.take(3).map((entry) => {entry.key: entry.value}).toList();
    List<Map<Indicator, double>> bottomScoreChanges = sortedScoreChanges.reversed.take(3).map((entry) => {entry.key: entry.value}).toList();

    List<MapEntry<Indicator, double>> sortedDiffChanges = diffChange.entries.toList()..sort((a, b) => a.value.compareTo(b.value)); // Sort ascending (smallest values first)

    List<Map<Indicator, double>> topDiffChanges = sortedDiffChanges.take(3).map((entry) => {entry.key: entry.value}).toList();
    List<Map<Indicator, double>> bottomDiffChanges = sortedDiffChanges.reversed.take(3).map((entry) => {entry.key: entry.value}).toList();

    state = state.copyWith(
        diffChange: diffChange, scoreChange: scoreChange, topDiffDecline: bottomDiffChanges, topDiffImprove: topDiffChanges, topScoreDecline: bottomScoreChanges, topScoreImprove: topScoreChanges);
  }

  void updateSurvey1(String survey) {
    SurveyMetric newsurvey1 = state.allComparableSurveys[survey]!;
    state = state.copyWith(
      survey1Data: newsurvey1,
    );
    calculateChange();
  }

  void updateSurvey2(String survey) {
    SurveyMetric newsurvey2 = state.allComparableSurveys[survey]!;
    state = state.copyWith(
      survey2Data: newsurvey2,
    );
    calculateChange();
  }

  String formatDate(
    String timestamp,
  ) {
    String datePart = timestamp.split('T')[0];
    List<String> parts = datePart.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    String _getMonthAbbreviation(int month) {
      final List<String> monthAbbreviations = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

      // Adjust for 0-based index
      return monthAbbreviations[month - 1];
    }

    String monthAbbr = _getMonthAbbreviation(month);

    // Create the base key
    return '$day $monthAbbr $year';
  }

  void initLoad() {
    logger.info("Init load for compare score");

    Map<String, SurveyMetric> allData = MetricsData().allSurveyMetrics;
    Map<String, SurveyMetric> allComparableSurveys = {};

    // Get surveys that can be displayed and change names to what can be displayed
    allData.forEach((key, value) {
      if (value.readyToDisplay) {
        // String formattedName = formatDate(key);
        // allComparableSurveys[formattedName] = value;
        allComparableSurveys[key] = value;
      }
    });

    logger.info("All comparable surveys: $allComparableSurveys");
    // Check if there are minimum 2 surveys. if yes. now we can calculate diff and score change plus show
    // if not. put up banner and display default values
    if (allComparableSurveys.length > 1) {
      logger.info("More than 2 surveys, Now processing surveys");
      SurveyMetric survey1 = allComparableSurveys.values.elementAt(0);
      SurveyMetric survey2 = allComparableSurveys.values.elementAt(1);
      state = state.copyWith(allComparableSurveys: allComparableSurveys, survey1Data: survey1, survey2Data: survey2, blur: false);

      calculateChange();
    } else {
      // Not enough surveys available. Use default surveys to calculate diff and core change values.
      logger.info("Less than 2 surveys. Loading default values");

      SurveyMetric survey1 = SurveyMetric.loadBlurredData(surveyStartDate: '25 March 2025');
      SurveyMetric survey2 = SurveyMetric.loadEmptyValues();
      state = state.copyWith(allComparableSurveys: {'Q1 2025': survey1, 'Q2 2025': survey2}, survey1Data: survey1, survey2Data: survey2, blur: true);
      calculateChange();
    }
  }
}
