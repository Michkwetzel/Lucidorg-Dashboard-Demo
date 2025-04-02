import 'package:flutter_riverpod/flutter_riverpod.dart';

//State of selection Buttons. Keep track of which button is selected by user.
class Loadingnotifier extends StateNotifier<bool> {
  Loadingnotifier() : super(false);

  void trueLoading() {
    state = true;
  }

  void falseLoading() {
    state = false;
  }
}
