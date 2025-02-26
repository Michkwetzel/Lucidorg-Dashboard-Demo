import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class SelectedDiffMatrix extends StateNotifier<Indicator> {
  SelectedDiffMatrix() : super(Indicator.companyIndex);

  void changeSBDisplay(Indicator indicator) {
    state = indicator;
  }
}
