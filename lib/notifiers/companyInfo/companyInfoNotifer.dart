import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyInfoNotifer extends StateNotifier<Map<String, String>> {
  CompanyInfoNotifer() : super({});

  void saveCompanyInfo(Map<String,String> infoList) {
    state = infoList;
  }

  bool get companyInfoEmpty => state.isEmpty;

}
