import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBarExpandStateNotifier extends StateNotifier<bool> {
  NavBarExpandStateNotifier() : super(true);

  void shrink() {
    state = false;
  }

  void expand() {
    state = true;
  }
}
