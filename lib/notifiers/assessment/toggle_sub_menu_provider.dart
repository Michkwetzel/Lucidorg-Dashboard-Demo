import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleSubMenuProvider extends StateNotifier<bool> {
  ToggleSubMenuProvider() : super(false);

  void toggleSubMenu() {
    state = !state;
  }

  void expand(){
    state = true;
  }

  void shrink(){
    state = false;
  }
}
