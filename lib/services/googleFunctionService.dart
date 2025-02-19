import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/notifiers/userResultsData/userResultsData.dart';
import 'package:platform_front/notifiers/createAssessment/emailListNotifer.dart';
import 'package:platform_front/notifiers/createAssessment/emailTemplateNotifer.dart';
import 'package:platform_front/notifiers/userProfileData/userProfileData.dart';
import 'package:platform_front/services/httpService.dart';

class GoogleFunctionService extends StateNotifier<bool> {
  final Logger logger = Logger("Googlefunctionservice");
  final EmailListNotifier _emailListNotifier;
  final EmailTemplateNotifer _emailTemplateNotifier;
  final UserProfileDataNotifier _userDataNotifier;

  List<String> get ceoEmails => _emailListNotifier.state.emailsCeo;
  List<String> get cSuiteEmails => _emailListNotifier.state.emailsCSuite;
  List<String> get employeeEmails => _emailListNotifier.state.emailsEmployee;
  String get emailTemplate => _emailTemplateNotifier.state.templateBody;
  String get userUID => _userDataNotifier.state.userUID!;
  String get companyUID => _userDataNotifier.state.companyUID!;
  String get subject => _emailTemplateNotifier.state.subject;

  GoogleFunctionService(
      {required EmailListNotifier emailListNotifier,
      required EmailTemplateNotifer emailTemplateNotifier,
      required UserProfileDataNotifier userDataNotifier,
      required UserResultsData activeAssessmentDataNotifier})
      : _emailListNotifier = emailListNotifier,
        _emailTemplateNotifier = emailTemplateNotifier,
        _userDataNotifier = userDataNotifier,
        super(false);

  Future<dynamic> verifyAuthToken({required String authToken}) {
    Map<String, dynamic> request = {'authToken': authToken};
    return HttpService.postRequest(path: kVerifyAuthTokenPath, request: request);
  }

  Future<dynamic> createUserProfile({required String? email, required String userUID, String? authToken, bool? employee, bool? guest}) {
    Map<String, dynamic> request = {'token': authToken ?? false, 'userEmail': email, 'userUID': userUID, 'employee': employee ?? false, 'guest': guest ?? false};
    return HttpService.postRequest(path: kCreateUserProfilePath, request: request);
  }

  Future<void> createAssessment() async {
    try {
      state = true;
      logger.info("Creating Assessment");

      //TODO: proper userUID input
      Map<String, dynamic> request = {
        'ceoEmails': ceoEmails,
        'cSuiteEmails': cSuiteEmails,
        'employeeEmails': employeeEmails,
        'emailTemplate': emailTemplate,
        'userUID': userUID,
        'subject': subject,
        'companyUID': companyUID
      };
      
      print(request);
      await HttpService.postRequest(path: kCreateAssessmentPath, request: request);
      state = false;
    } on Exception catch (e) {
      state = false;
      rethrow;
    }
  }

  Future<void> saveCompanyInfo(Map<String, dynamic> companyInfo) async {
    await HttpService.postRequest(path: ksaveCompanyInfoPath, request: {'companyInfo': companyInfo, 'companyUID': companyUID});
  }

  // Future<void> createTokens({int numTokens = 1, int numCompanyUIds = 1}) {
  //   logger.info("Creating Tokens");
  //   Map<String, int> request = {'numTokens': numTokens, 'numCompanyUIds': numCompanyUIds};
  //   return HttpService.postRequest(path: kCreateTokensPath, request: request);
  // }
}
