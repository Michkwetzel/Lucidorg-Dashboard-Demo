import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class ScoreCompareState {
  final bool canShow;
  final SurveyMetric survey1;
  final SurveyMetric survey2;
  final String survey1Name;
  final String survey2Name;
  final Map<Indicator, double> indicatorsChangeDiff;
  final Map<Indicator, double> indicatorsChangeScore;
  final bool initialized; // Add this flag to track initialization

  ScoreCompareState(
      {required this.canShow,
      this.initialized = false, // Default to false

      required this.survey1,
      required this.survey2,
      required this.indicatorsChangeDiff,
      required this.indicatorsChangeScore,
      required this.survey1Name,
      required this.survey2Name});

  ScoreCompareState copyWith(
      {bool? canShow,
      SurveyMetric? survey1,
      SurveyMetric? survey2,
      bool? initialized,
      Map<Indicator, double>? indicatorsChangeDiff,
      Map<Indicator, double>? indicatorsChangeScore,
      String? survey1Name,
      String? survey2Name}) {
    return ScoreCompareState(
      canShow: canShow ?? this.canShow,
      survey1: survey1 ?? this.survey1,
      survey2: survey2 ?? this.survey2,
      indicatorsChangeDiff: indicatorsChangeDiff ?? this.indicatorsChangeDiff,
      indicatorsChangeScore: indicatorsChangeScore ?? this.indicatorsChangeScore,
      survey1Name: survey1Name ?? this.survey1Name,
      survey2Name: survey2Name ?? this.survey2Name,
      initialized: initialized ?? this.initialized,
    );
  }
}

class ScoreCompareProvider extends StateNotifier<ScoreCompareState> {
  ScoreCompareProvider()
      : super(ScoreCompareState(
            canShow: false,
            survey1: SurveyMetric.loadDefaultValues(),
            survey2: SurveyMetric.loadDefaultValues(),
            indicatorsChangeDiff: {},
            indicatorsChangeScore: {},
            survey1Name: 'Q1',
            survey2Name: 'Q2'));

  void setSurveyNames(String survey1Name, survey2Name) {
    
    state = state.copyWith(
      survey1Name: survey1Name,
      survey2Name: survey2Name,
    );
  }

  void calculateChange() {
    Map<Indicator, double> indicatorsChangeDiff = {};
    Map<Indicator, double> indicatorsChangeScore = {};

    Map<Indicator, double> companyBenchmark1 = state.survey1.companyBenchmarks;
    Map<Indicator, double> companyBenchmark2 = state.survey2.companyBenchmarks;

    Map<Indicator, double> companyDiff1 = state.survey1.diffScores;
    Map<Indicator, double> companyDiff2 = state.survey2.diffScores;

    companyBenchmark1.forEach((indicator, value) {
      indicatorsChangeScore[indicator] = companyBenchmark2[indicator]! - value;
      indicatorsChangeDiff[indicator] = companyDiff2[indicator]! - companyDiff1[indicator]!;
    });

    state = state.copyWith(indicatorsChangeDiff: indicatorsChangeDiff, indicatorsChangeScore: indicatorsChangeScore);
  }

  List<Indicator> returnBiggestScoreIncrease() {
    final sortedEntries = state.indicatorsChangeScore.entries.toList()..sort((a, b) => b.value.compareTo(a.value)); // Sort in descending order

    return sortedEntries.take(3).map((entry) => entry.key).toList();
  }

  List<Indicator> returnBiggestScoreDecrease() {
    final sortedEntries = state.indicatorsChangeScore.entries.toList()..sort((a, b) => a.value.compareTo(b.value)); // Sort in ascending order

    return sortedEntries.take(3).map((entry) => entry.key).toList();
  }

  List<Indicator> returnBiggestdiffDecrease() {
    final sortedEntries = state.indicatorsChangeScore.entries.toList()..sort((a, b) => b.value.compareTo(a.value)); // Sort in descending order

    return sortedEntries.take(3).map((entry) => entry.key).toList();
  }

  List<Indicator> returnBiggestdiffIncrease() {
    final sortedEntries = state.indicatorsChangeScore.entries.toList()..sort((a, b) => a.value.compareTo(b.value)); // Sort in ascending order

    return sortedEntries.take(3).map((entry) => entry.key).toList();
  }

  void updateSurvey1(SurveyMetric survey) {
    SurveyMetric newsurvey1 = survey;

    state = state.copyWith(
      survey1: newsurvey1,
    );
  }

  void updateSurvey2(SurveyMetric survey) {
    SurveyMetric newsurvey2 = survey;

    state = state.copyWith(
      survey2: newsurvey2,
    );
  }

  void initLoad() {
    Map<String, SurveyMetric> allData = MetricsData().allSurveyMetrics;

    if (allData.length > 1) {
      print("More than 2 surveys");
      //There are more than 1 survey
      SurveyMetric survey1 = allData.values.elementAt(0);
      SurveyMetric survey2 = allData.values.elementAt(1);
      survey1.printData();
      survey2.printData();

      // Both have above 70 participation and all 3 departments fill in
      if (survey1.readyToDisplay && survey2.readyToDisplay) {
        print("both are ready");
        state = state.copyWith(
          canShow: true,
          survey1: survey1,
          survey2: survey2,
        );
        calculateChange();
        return;
      }
    }
    state = state.copyWith(
      canShow: false,
    );
  }
}
