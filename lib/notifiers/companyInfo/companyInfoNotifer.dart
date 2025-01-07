import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyInfoNotifer extends StateNotifier<Map<String, String>> {
  CompanyInfoNotifer() : super({'companyName' : ''});

  void saveCompanyInfo(Map<String,String> infoList) {
    state = infoList;
  }

  String get companyName => state['companyName'] ?? '';

  bool get companyInfoEmpty => state['companyName'] == '';

}
