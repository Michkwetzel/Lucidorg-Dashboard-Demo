import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class EmailListState {
  final List<String> emailsCeo;
  final List<String> emailsCSuite;
  final List<String> emailsEmployee;
  final bool addEmailDisplay;

  EmailListState({this.emailsCeo = const [], this.emailsCSuite = const [], this.emailsEmployee = const [], this.addEmailDisplay = false});

  // CopyWith function to create a new instance with optional parameter changes
  EmailListState copyWith({
    List<String>? emailsCeo,
    List<String>? emailsCSuite,
    List<String>? emailsEmployee,
    bool? addEmailDisplay,
  }) {
    return EmailListState(
      emailsCeo: emailsCeo ?? this.emailsCeo,
      emailsCSuite: emailsCSuite ?? this.emailsCSuite,
      emailsEmployee: emailsEmployee ?? this.emailsEmployee,
      addEmailDisplay: addEmailDisplay ?? this.addEmailDisplay,
    );
  }
}

class EmailListNotifier extends StateNotifier<EmailListState> {
  EmailListNotifier()
      : super(EmailListState(
          emailsCeo: [],
          emailsCSuite: [],
          emailsEmployee: [],
        ));

  bool get emailsEmpty => state.emailsCSuite.isEmpty && state.emailsCeo.isEmpty && state.emailsEmployee.isEmpty;

  bool get moreThan5Emails => state.emailsCSuite.length + state.emailsCeo.length + state.emailsEmployee.length > 5;

  Future<void> loadEmails() async {}

  Future<void> removeEmail(String emailId) async {}

  void deleteSingleEmail({required int index, required EmailListRadioButtonType type}) {
    switch (type) {
      case EmailListRadioButtonType.cSuite:
        state = state.copyWith(emailsCSuite: List.from(state.emailsCSuite)..removeAt(index));
        break;
      case EmailListRadioButtonType.ceo:
        state = state.copyWith(emailsCeo: List.from(state.emailsCeo)..removeAt(index));
        break;
      case EmailListRadioButtonType.employee:
        state = state.copyWith(emailsEmployee: List.from(state.emailsEmployee)..removeAt(index));
        break;
    }
  }

  int listLength(EmailListRadioButtonType type) {
    switch (type) {
      case EmailListRadioButtonType.cSuite:
        return state.emailsCSuite.length;
      case EmailListRadioButtonType.ceo:
        return state.emailsCeo.length;
      case EmailListRadioButtonType.employee:
        return state.emailsEmployee.length;
    }
  }

  void deleteAllEmails() {
    state = state.copyWith(emailsCSuite: [], emailsCeo: [], emailsEmployee: []);
  }

  void deleteGroupEmails(EmailListRadioButtonType type) {
    switch (type) {
      case EmailListRadioButtonType.cSuite:
        state = state.copyWith(emailsCSuite: []);
      case EmailListRadioButtonType.ceo:
        state = state.copyWith(emailsCeo: []);
      case EmailListRadioButtonType.employee:
        state = state.copyWith(emailsEmployee: []);
    }
  }

  void changeToAddEmailsDisplay() {
    state = state.copyWith(addEmailDisplay: true);
  }

  void changeToViewEmailsDisplay() {
    state = state.copyWith(addEmailDisplay: false);
  }

  void addEmails(List<String> emails, EmailListRadioButtonType type) {
    switch (type) {
      case EmailListRadioButtonType.cSuite:
        state = state.copyWith(emailsCSuite: [...state.emailsCSuite, ...emails].toSet().toList());
      case EmailListRadioButtonType.ceo:
        state = state.copyWith(emailsCeo: [...state.emailsCeo, ...emails].toSet().toList());
      case EmailListRadioButtonType.employee:
        state = state.copyWith(emailsEmployee: [...state.emailsEmployee, ...emails].toSet().toList());
    }
  }

  void clearEmails(){
    state = EmailListState();
  }
}
