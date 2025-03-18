import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class SelectedHomeDisplayNotifer extends StateNotifier<HomeSection> {
  SelectedHomeDisplayNotifer() : super(HomeSection.home);

  void changeDisplay(HomeSection newDisplay) {
    state = newDisplay;
  }
}


