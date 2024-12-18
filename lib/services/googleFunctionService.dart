import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/services/httpService.dart';

class Googlefunctionservice extends StateNotifier<bool> {
  final Logger logger = Logger("Googlefunctionservice");

  Googlefunctionservice() : super(true);

  Future<dynamic> verifyAuthToken({required String authToken}) {
    Map<String, dynamic> request = {'authToken': authToken};
    return HttpService.postRequest(path: kVerifyAuthTokenPath, request: request);
  }

  Future<dynamic> createUserProfile({required String? email, required String userUID, String? authToken, bool? employee, bool? guest}) {
    Map<String, dynamic> request = {'token': authToken, 'userEmail': email, 'userUID': userUID, 'employee': employee ?? false, 'guest': guest ?? false};
    return HttpService.postRequest(path: kCreateUserProfilePath, request: request);
  }

}
