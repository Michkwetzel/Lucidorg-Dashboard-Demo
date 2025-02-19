import 'package:flutter_riverpod/flutter_riverpod.dart';

//State of selection Buttons. Keep track of which button is selected by user.
class AuthLoadState extends StateNotifier<bool> {
  AuthLoadState() : super(false);

  void loading() {
    state = true;
  }

  void finished() {
    state = false;
  }
}
