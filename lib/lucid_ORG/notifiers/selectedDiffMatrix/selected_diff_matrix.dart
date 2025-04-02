import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class SelectedDiffMatrix extends StateNotifier<Indicator> {
  SelectedDiffMatrix() : super(Indicator.companyIndex);

  void changeSBDisplay(Indicator indicator) {
    state = indicator;
  }
}
