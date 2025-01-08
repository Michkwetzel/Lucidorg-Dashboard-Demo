import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/notifiers/auth/authFireStoreServiceNotifier.dart';
import 'package:platform_front/notifiers/companyInfo/companyInfoNotifer.dart';
import 'package:platform_front/notifiers/createAssessment/emailListNotifer.dart';
import 'package:platform_front/notifiers/createAssessment/emailTemplateNotifer.dart';
import 'package:platform_front/services/httpService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Googlefunctionservice extends StateNotifier<bool> {
  final Logger logger = Logger("Googlefunctionservice");
  final EmailListNotifier _emailListNotifier;
  final Emailtemplatenotifer _emailTemplateNotifier;
  final CompanyInfoNotifer _companyInfoNotifer;
  final AuthFirestoreServiceNotifier _authFirestoreServiceNotifier;

  List<String> get ceoEmails => _emailListNotifier.state.emailsCeo;
  List<String> get cSuiteEmails => _emailListNotifier.state.emailsCSuite;
  List<String> get employeeEmails => _emailListNotifier.state.emailsEmployee;
  String get emailTemplate => _emailTemplateNotifier.state.templateBody;
  Map<String, String> get companyInfo => _companyInfoNotifer.state;
  User get user => _authFirestoreServiceNotifier.state.currentUser!;

  Googlefunctionservice(this._emailListNotifier, this._emailTemplateNotifier, this._companyInfoNotifer, this._authFirestoreServiceNotifier) : super(true);

  Future<dynamic> verifyAuthToken({required String authToken}) {
    Map<String, dynamic> request = {'authToken': authToken};
    return HttpService.postRequest(path: kVerifyAuthTokenPath, request: request);
  }

  Future<dynamic> createUserProfile({required String? email, required String userUID, String? authToken, bool? employee, bool? guest}) {
    Map<String, dynamic> request = {'token': authToken ?? false, 'userEmail': email, 'userUID': userUID, 'employee': employee ?? false, 'guest': guest ?? false};
    return HttpService.postRequest(path: kCreateUserProfilePath, request: request);
  }

  Future<Stream<QuerySnapshot>> getResultsStream() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      // Wait for Firestore to be ready, but don't terminate
      await _firestore.waitForPendingWrites();

      final docCompanyUIDSnapshot = await _firestore.collection('surveyData').doc('dBR3TMXWGxm_LqJDXd7vkw').get();

      final latestSurveyDocName = docCompanyUIDSnapshot.data()?['latestSurvey'];

      if (latestSurveyDocName == null) {
        throw Exception('Latest survey not found');
      }

      // Return the stream without terminating the connection
      return _firestore.collection('surveyData/dBR3TMXWGxm_LqJDXd7vkw/$latestSurveyDocName/results/data').snapshots();
    } catch (e) {
      print('Error in getResultsStream: $e');
      throw e;
    }
  }

  Future<dynamic> createAssessment() {
    logger.info("Creating Assessment");

    //TODO: proper userUID input
    Map<String, dynamic> request = {
      'ceoEmails': ceoEmails,
      'cSuiteEmails': cSuiteEmails,
      'employeeEmails': employeeEmails,
      'emailTemplate': emailTemplate,
      'companyInfo': companyInfo,
      'userUID': 'wvsDmspjXx6Q24T48ofP'
    };
    print(request);
    return HttpService.postRequest(path: kCreateAssessmentPath, request: request);
  }
}
