import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class ScoreCompareState {
  final bool canShow;
  final SurveyMetric survey1;
  final SurveyMetric survey2;

  ScoreCompareState({required this.canShow, required this.survey1, required this.survey2});

  ScoreCompareState copyWith({bool? canShow, SurveyMetric? survey1, SurveyMetric? survey2}) {
    return ScoreCompareState(canShow: canShow ?? this.canShow, survey1: survey1 ?? this.survey1, survey2: survey2 ?? this.survey2);
  }
}

class ScoreCompareProvider extends StateNotifier<ScoreCompareState> {
  ScoreCompareProvider()
      : super(ScoreCompareState(
          canShow: false,
          survey1: SurveyMetric.loadDefaultValues(),
          survey2: SurveyMetric.loadDefaultValues(),
        ));

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
        return;
      }
    }
    state = state.copyWith(
      canShow: false,
    );
  }
}
