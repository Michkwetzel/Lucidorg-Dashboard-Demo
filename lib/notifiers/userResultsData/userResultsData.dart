import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/services/firebaseServiceNotifier.dart';

class UserResultsDataState {
  final String? latestAssessmentDocName;

  UserResultsDataState({this.latestAssessmentDocName});

  UserResultsDataState copyWith({String? latestAssessmentDocName}) {
    return UserResultsDataState(latestAssessmentDocName: latestAssessmentDocName ?? this.latestAssessmentDocName);
  }
}

class UserResultsData extends StateNotifier<UserResultsDataState> {
  final FirebaseServiceNotifier firebaseservicenotifier;
  Logger logger = Logger("ActiveAssessmentDataNotifier");

  UserResultsData({required this.firebaseservicenotifier}) : super(UserResultsDataState());

  bool get noActiveSurvey => state.latestAssessmentDocName == null;
  String? get activeSurvey => state.latestAssessmentDocName;

  Future<void> setAssessmentDocName(String? companyUID) async {
    final docName = await firebaseservicenotifier.getLatestAssessment(companyUID);
    logger.info('Set current Assessment to: $docName');

    state = state.copyWith(latestAssessmentDocName: docName);
  }


}
