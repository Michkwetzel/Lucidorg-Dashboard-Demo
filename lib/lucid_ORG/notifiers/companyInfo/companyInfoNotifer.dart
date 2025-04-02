import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/services/googleFunctionService.dart';

class CompanyInfoState {
  Map<String, String> companyInfo;

  CompanyInfoState({required this.companyInfo});

  CompanyInfoState copyWith({Map<String, String>? companyInfo}) {
    return CompanyInfoState(
      companyInfo: companyInfo ?? this.companyInfo,
    );
  }
}

//TODO: finish this.

//For Company Info
class CompanyInfoNotifer extends StateNotifier<Map<String, String>> {
  final GoogleFunctionService googlefunctionserviceProvider;

  CompanyInfoNotifer({required this.googlefunctionserviceProvider}) : super({'companyName': ''});

  Future<void> saveCompanyInfo(Map<String, String> companyInfoMap) async {
    state = companyInfoMap;
    await googlefunctionserviceProvider.saveCompanyInfo(state);
  }

  void setCompanyInfo(Map<String, String> companyInfoMap) {
    state = companyInfoMap;
  }

  String get companyName => state['companyName'] ?? '';

  bool get companyInfoEmpty => state['companyName'] == '';

  void clearCompanyInfo(){
    state = {'companyName': ''};
  }
}
