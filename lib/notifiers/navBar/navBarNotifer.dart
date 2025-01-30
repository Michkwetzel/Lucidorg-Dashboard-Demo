import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class Navbarnotifer extends StateNotifier<NavBarButtonType> {
  Navbarnotifer() : super(NavBarButtonType.home);

  void changeDisplay(NavBarButtonType display) {
    state = display;
  }
}
