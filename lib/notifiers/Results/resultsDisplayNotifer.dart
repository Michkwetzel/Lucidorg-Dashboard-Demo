import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class ResultsSelectedSection extends StateNotifier<ResultSection> {
  ResultsSelectedSection() : super(ResultSection.areaScore);

  void setDisplay(ResultSection section){
    state = section;
  }
}
