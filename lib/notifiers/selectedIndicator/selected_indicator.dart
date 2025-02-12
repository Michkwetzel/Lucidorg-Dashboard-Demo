import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class SelectedIndicator extends StateNotifier<Indicator> {
  SelectedIndicator() : super(Indicator.orgAlign);

  void changeMainDisplay(Indicator indicator) {
    state = indicator;
  }
}
