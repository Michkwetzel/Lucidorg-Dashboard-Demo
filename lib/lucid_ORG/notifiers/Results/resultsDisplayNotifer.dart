import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class ResultsDisplayNotifier extends StateNotifier<ResultSection> {
  ResultsDisplayNotifier() : super(ResultSection.overview);

  void setDisplay(ResultSection section){
    state = section;
  }
}
