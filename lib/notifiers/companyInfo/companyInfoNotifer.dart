import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/services/googleFunctionService.dart';


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
}
