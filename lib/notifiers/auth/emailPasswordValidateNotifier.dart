import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPasswordValidationState {
  final String? emailError;
  final String? passwordError;

  EmailPasswordValidationState({this.emailError, this.passwordError});

  EmailPasswordValidationState copyWith({String? emailError, String? passwordError}) {
    if (emailError == '') {
      return EmailPasswordValidationState(
        emailError: null,
        passwordError: passwordError ?? this.passwordError,
      );
    } else if (passwordError == '') {
      return EmailPasswordValidationState(
        emailError: emailError ?? this.emailError,
        passwordError: null,
      );
    } else {
      return EmailPasswordValidationState(
        emailError: emailError ?? this.emailError,
        passwordError: passwordError ?? this.passwordError,
      );
    }
  }
}

class EmailpasswordvalidateNotifer extends StateNotifier<EmailPasswordValidationState> {
  EmailpasswordvalidateNotifer() : super(EmailPasswordValidationState());

  void validateEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email.isEmpty) {
      state = state.copyWith(emailError: 'Email cannot be empty');
    } else if (!emailRegex.hasMatch(email)) {
      state = state.copyWith(emailError: 'Invalid email format');
    } else {
      state = state.copyWith(emailError: '');
    }
    print('EmailError: ${state.emailError}');
  }

  void validatePassword(String password) {
    if (password.isEmpty) {
      state = state.copyWith(passwordError: 'Password cannot be empty');
    } else if (password.length < 6) {
      state = state.copyWith(passwordError: 'Password must be at least 6 characters');
    } else {
      state = state.copyWith(passwordError: '');
    }
    print('PasswordState: ${state.passwordError}');
  }

  bool get isValid => state.emailError == null && state.passwordError == null;

  void setPasswordError(String passwordError) {
    state = state.copyWith(passwordError: passwordError);
  }

  void setEmailError(String emailError) {
    state = state.copyWith(emailError: emailError);
  }
}
