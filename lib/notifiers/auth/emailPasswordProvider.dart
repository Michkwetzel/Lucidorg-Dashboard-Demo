import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPasswordState {
  final String password;
  final String email;

  EmailPasswordState({
    this.password = '',
    this.email = '',
  });

  EmailPasswordState copyWith({
    String? password,
    String? email,
  }) {
    return EmailPasswordState(
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }
}

class EmailPasswordProvider extends StateNotifier<EmailPasswordState> {
  EmailPasswordProvider() : super(EmailPasswordState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  String getPassword() {
    return state.password;
  }

  String getEmail() {
    return state.email;
  }

  void reset() {
    state = EmailPasswordState();
  }
}
