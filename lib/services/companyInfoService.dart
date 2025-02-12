import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/notifiers/companyInfo/companyInfoNotifer.dart';
import 'package:platform_front/notifiers/userProfileData/userProfileData.dart';
import 'package:platform_front/services/firebaseServiceNotifier.dart';

class CompanyInfoService extends StateNotifier<bool> {
  final Logger logger = Logger("InitialDataloadProvider");
  final FirebaseServiceNotifier firebaseService;
  final UserProfileDataNotifier userProfileDataNotifier;
  final CompanyInfoNotifer companyInfoNotifer;

  CompanyInfoService({required this.firebaseService, required this.userProfileDataNotifier, required this.companyInfoNotifer}) : super(true);

  Future<void> getCompanyInfo() async {
    state = true;
    var companyInfo = await firebaseService.getCompanyInfo(userProfileDataNotifier.companyUID);
    if (companyInfo != null) {
      //Company has companyInfo saved. if this is null then nothing has been saved yet.
      companyInfoNotifer.setCompanyInfo(companyInfo);
    }
    state = false;
  }
}
