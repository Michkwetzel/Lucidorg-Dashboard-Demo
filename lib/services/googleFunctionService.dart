import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/notifiers/assessment/currentAssessment/reminderEmailTemplateProvider.dart';
import 'package:platform_front/lucid_ORG/notifiers/userResultsData/userResultsData.dart';
import 'package:platform_front/lucid_ORG/notifiers/assessment/createAssessment/emailListNotifer.dart';
import 'package:platform_front/lucid_ORG/notifiers/assessment/createAssessment/emailTemplateNotifer.dart';
import 'package:platform_front/auth/user_profile_data/userProfileData.dart';
import 'package:platform_front/services/httpService.dart';

class GoogleFunctionServiceState {
  bool loading;
  String loadingMessage;

  GoogleFunctionServiceState({this.loading = false, this.loadingMessage = 'Loading...'});

  GoogleFunctionServiceState copyWith({bool? loading, String? loadingMessage}) {
    return GoogleFunctionServiceState(
      loading: loading ?? this.loading,
      loadingMessage: loadingMessage ?? this.loadingMessage,
    );
  }
}

class GoogleFunctionService extends StateNotifier<GoogleFunctionServiceState> {
  final Logger logger = Logger("Googlefunctionservice");
  final EmailListNotifier _emailListNotifier;
  final EmailTemplateNotifer _emailTemplateNotifier;
  final ReminderEmailTemplateNotifer _reminderEmailTemplateNotifer;
  final UserProfileDataNotifier _userDataNotifier;

  List<String> get ceoEmails => _emailListNotifier.state.emailsCeo;
  List<String> get cSuiteEmails => _emailListNotifier.state.emailsCSuite;
  List<String> get employeeEmails => _emailListNotifier.state.emailsEmployee;
  String get emailTemplate => _emailTemplateNotifier.state.templateBody;
  String? get reminderTemplate => _reminderEmailTemplateNotifer.state.templateBody;
  String? get reminderSubject => _reminderEmailTemplateNotifer.state.subject;
  String? get reminderEmailFrom => _reminderEmailTemplateNotifer.state.emailFrom;
  String? get userUID => _userDataNotifier.state.userUID;
  String? get companyUID => _userDataNotifier.state.companyUID;
  String? get subject => _emailTemplateNotifier.state.subject;
  String? get latestDocName => _userDataNotifier.latestSurveyDocName;
  String? get emailFrom => _emailTemplateNotifier.state.emailFrom;

  GoogleFunctionService(
      {required EmailListNotifier emailListNotifier,
      required EmailTemplateNotifer emailTemplateNotifier,
      required UserProfileDataNotifier userDataNotifier,
      required UserResultsData activeAssessmentDataNotifier,
      required ReminderEmailTemplateNotifer reminderEmailTemplateNotifer})
      : _emailListNotifier = emailListNotifier,
        _emailTemplateNotifier = emailTemplateNotifier,
        _userDataNotifier = userDataNotifier,
        _reminderEmailTemplateNotifer = reminderEmailTemplateNotifer,
        super(GoogleFunctionServiceState());

  Future<dynamic> verifyAuthToken({required String authToken}) {
    Map<String, dynamic> request = {'authToken': authToken};
    return HttpService.postRequest(path: kVerifyAuthTokenPath, request: request);
  }

  Future<dynamic> createUserProfile({required String? email, required String userUID, String? authToken, bool? employee, bool? guest, bool? exec}) {
    Map<String, dynamic> request = {'token': authToken ?? 'none', 'userEmail': email, 'userUID': userUID, 'employee': employee ?? false, 'guest': guest ?? false, 'exec': exec ?? false};
    return HttpService.postRequest(path: kCreateUserProfilePath, request: request);
  }

  Future<void> createAssessment({bool guest = false}) async {
    try {
      state = state.copyWith(loadingMessage: 'Creating Assessment!', loading: true);
      logger.info("Creating Assessment");

      // Simulate a 2-second delay for guest account
      await Future.delayed(const Duration(seconds: 4));

      // Return fake success for guest account without making actual API call
      logger.info("Guest account - returning fake success");
      state = state.copyWith(loadingMessage: 'Loading!', loading: false);
      return;

      // Actual code
      // Map<String, dynamic> request = {
      //   'ceoEmails': ceoEmails,
      //   'cSuiteEmails': cSuiteEmails,
      //   'employeeEmails': employeeEmails,
      //   'emailTemplate': emailTemplate,
      //   'userUID': userUID,
      //   'subject': subject,
      //   'companyUID': companyUID,
      //   'emailFrom': emailFrom,
      //   'guest': guest
      // };

      // await HttpService.postRequest(path: kCreateAssessmentPath, request: request);
      // state = state.copyWith(loadingMessage: 'Loading!', loading: false);
    } on Exception {
      state = state.copyWith(loadingMessage: 'Loading!', loading: false);
      rethrow;
    }
  }

  Future<void> saveCompanyInfo(Map<String, dynamic> companyInfo) async {
    state = state.copyWith(loading: true);

    // Simulate a 2-second delay for guest account
    await Future.delayed(const Duration(seconds: 4));

    // Return fake success for guest account without making actual API call
    logger.info("Guest account - returning fake success");
    state = state.copyWith(loading: false);
    return;
    // actual code
    // await HttpService.postRequest(path: ksaveCompanyInfoPath, request: {'companyInfo': companyInfo, 'companyUID': companyUID});
  }

  Future<void> sendEmailReminder() async {
    try {
      logger.info("Sending Reminder");

      state = state.copyWith(loading: true);

      // Simulate a 2-second delay for guest account
      await Future.delayed(const Duration(seconds: 4));

      // Return fake success for guest account without making actual API call
      logger.info("Guest account - returning fake success");
      state = state.copyWith(loading: false);
      return;

      // actual code
      // await HttpService.postRequest(path: ksendEmailReminderPath, request: {
      //   'currentSurvey': latestDocName,
      //   'companyUID': companyUID,
      //   'emailTemplate': reminderTemplate,
      //   'subject': reminderSubject,
      //   'emailFrom': reminderEmailFrom,
      // });
      // state = state.copyWith(loading: false);
    } on Exception catch (e) {
      state = state.copyWith(loading: false);

      logger.severe('Error sending email reminder: $e');
    }
  }

  // Next is all my HR google funtion services.

  Future<void> createNewJobSearch(Map<String, dynamic> jobSearchData) async {
    String title = jobSearchData['title'];
    List<String> emailList = jobSearchData['emailList'];
    Map<String, double> benchmarks = jobSearchData['benchmarks'];
    String emailFrom = jobSearchData['emailFrom'];
    String subject = jobSearchData['subject'];
    String emailBody = jobSearchData['emailBody'];

    print('title: $title, emailList: $emailList, benchmarks: $benchmarks, emailFrom: $emailFrom, subject: $subject, emailBody: $emailBody');

    // Simulate a 2-second delay for guest account
    await Future.delayed(const Duration(seconds: 2));

    // Return fake success for guest account without making actual API call
    logger.info("Guest account - returning fake success");
    return;

    // The code below is unreachable but kept for reference
    try {
      await HttpService.postRequest(
        path: kCreateJobSearchPath,
        request: {'title': title, 'emailList': emailList, 'benchmarks': benchmarks, 'emailFrom': emailFrom, 'subject': subject, 'emailBody': emailBody, 'companyUID': companyUID},
      );
    } on Exception catch (e) {
      logger.severe("Error sending CreateNewJobSearch: $e");
    }
  }
}
