import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class SelectedIndicator extends StateNotifier<Indicator> {
  SelectedIndicator() : super(Indicator.orgAlign);

  void changeMainDisplay(Indicator indicator) {
    state = indicator;
  }
}
