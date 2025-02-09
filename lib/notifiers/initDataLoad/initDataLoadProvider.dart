import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/notifiers/companyInfo/companyInfoNotifer.dart';
import 'package:platform_front/notifiers/userProfileData/userProfileData.dart';
import 'package:platform_front/services/firebaseServiceNotifier.dart';

class InitDataloadProvider extends StateNotifier<bool> {
  final Logger logger = Logger("InitialDataloadProvider");
  final FirebaseServiceNotifier firebaseService;
  final UserProfileDataNotifier userProfileDataNotifier;
  final CompanyInfoNotifer companyInfoNotifer;

  InitDataloadProvider({required this.firebaseService, required this.userProfileDataNotifier, required this.companyInfoNotifer}) : super(true);

  Future<void> initDataload() async {
    // Initial fetching of Data

    //Fetch Company Info
    var companyInfo = await firebaseService.getCompanyInfo(userProfileDataNotifier.companyUID);
    if (companyInfo != null) {
      //Company has companyInfo saved. if this is null then nothing has been saved yet.
      companyInfoNotifer.setCompanyInfo(companyInfo);
    }
    
  }
}
