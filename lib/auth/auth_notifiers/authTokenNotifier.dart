import 'package:flutter_riverpod/flutter_riverpod.dart';

class Authtokennotifier extends StateNotifier<String> {
  Authtokennotifier() : super("");

  void setToken(String token) {
    state = token;
  }
}
