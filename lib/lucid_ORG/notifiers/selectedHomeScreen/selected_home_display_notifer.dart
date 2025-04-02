import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class SelectedHomeDisplayNotifer extends StateNotifier<HomeSection> {
  SelectedHomeDisplayNotifer() : super(HomeSection.home);

  void changeDisplay(HomeSection newDisplay) {
    state = newDisplay;
  }
}


