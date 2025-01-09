import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/services/firebaseServiceNotifier.dart';

class ActiveAssessmentState {
  final String? docName;

  ActiveAssessmentState({this.docName});

  ActiveAssessmentState copyWith({String? docName}) {
    return ActiveAssessmentState(docName: docName ?? this.docName);
  }
}

class ActiveAssessmentDataNotifier extends StateNotifier<ActiveAssessmentState> {
  final FirebaseServiceNotifier firebaseservicenotifier;
  Logger logger = Logger("ActiveAssessmentDataNotifier");

  ActiveAssessmentDataNotifier({required this.firebaseservicenotifier}) : super(ActiveAssessmentState());

  bool get noActiveSurvey => state.docName == null;
  String? get activeSurvey => state.docName;

  Future<void> setAssessmentDocName(String? companyUID) async {
    final docName = await firebaseservicenotifier.getLatestAssessment(companyUID);
    logger.info('Set Assessment $docName');

    state = state.copyWith(docName: docName);
  }
}
