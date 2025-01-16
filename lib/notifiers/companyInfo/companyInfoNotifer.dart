import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/services/googleFunctionService.dart';

class CompanyInfoNotifer extends StateNotifier<Map<String, String>> {
  final GoogleFunctionService googlefunctionserviceProvider;

  CompanyInfoNotifer({required this.googlefunctionserviceProvider}) : super({'companyName': ''});

  Future<void> saveCompanyInfo(Map<String, String> infoList) async {
    state = infoList;
    await googlefunctionserviceProvider.saveCompanyInfo(state);
  }

  String get companyName => state['companyName'] ?? '';

  bool get companyInfoEmpty => state['companyName'] == '';
}
