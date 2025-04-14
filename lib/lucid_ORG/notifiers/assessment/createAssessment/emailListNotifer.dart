import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/auth/user_profile_data/userProfileData.dart';
import 'package:platform_front/services/email_storage.dart';

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
  UserProfileDataNotifier userProfileDataNotifier;

  EmailListNotifier(this.userProfileDataNotifier)
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
        EmailStorage.saveEmails(EmailStorage.KEY_CSUITE_EMAILS, state.emailsCSuite, userID: userProfileDataNotifier.userUID);
        break;
      case EmailListRadioButtonType.ceo:
        state = state.copyWith(emailsCeo: List.from(state.emailsCeo)..removeAt(index));
        EmailStorage.saveEmails(EmailStorage.KEY_CEO_EMAILS, state.emailsCeo, userID: userProfileDataNotifier.userUID);
        break;
      case EmailListRadioButtonType.employee:
        state = state.copyWith(emailsEmployee: List.from(state.emailsEmployee)..removeAt(index));
        EmailStorage.saveEmails(EmailStorage.KEY_EMPLOYEE_EMAILS, state.emailsEmployee, userID: userProfileDataNotifier.userUID);
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
        EmailStorage.clearDepartmentEmails(EmailStorage.KEY_CSUITE_EMAILS, userID: userProfileDataNotifier.userUID);
      case EmailListRadioButtonType.ceo:
        state = state.copyWith(emailsCeo: []);
        EmailStorage.clearDepartmentEmails(EmailStorage.KEY_CEO_EMAILS, userID: userProfileDataNotifier.userUID);
      case EmailListRadioButtonType.employee:
        state = state.copyWith(emailsEmployee: []);
        EmailStorage.clearDepartmentEmails(EmailStorage.KEY_EMPLOYEE_EMAILS, userID: userProfileDataNotifier.userUID);
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
        print('Saving csuite emails: ${state.emailsCSuite} to storage');
        EmailStorage.saveEmails(EmailStorage.KEY_CSUITE_EMAILS, state.emailsCSuite, userID: userProfileDataNotifier.userUID);
      case EmailListRadioButtonType.ceo:
        state = state.copyWith(emailsCeo: [...state.emailsCeo, ...emails].toSet().toList());
        EmailStorage.saveEmails(EmailStorage.KEY_CEO_EMAILS, state.emailsCeo, userID: userProfileDataNotifier.userUID);
      case EmailListRadioButtonType.employee:
        state = state.copyWith(emailsEmployee: [...state.emailsEmployee, ...emails].toSet().toList());
        EmailStorage.saveEmails(EmailStorage.KEY_EMPLOYEE_EMAILS, state.emailsEmployee, userID: userProfileDataNotifier.userUID);
    }
  }

  void loadEmailsFromCache() {
    state = state.copyWith(
        emailsCSuite: EmailStorage.loadEmails(EmailStorage.KEY_CSUITE_EMAILS, userID: userProfileDataNotifier.userUID),
        emailsCeo: EmailStorage.loadEmails(EmailStorage.KEY_CEO_EMAILS, userID: userProfileDataNotifier.userUID),
        emailsEmployee: EmailStorage.loadEmails(EmailStorage.KEY_EMPLOYEE_EMAILS, userID: userProfileDataNotifier.userUID));
  }

  void clearEmails() {
    state = EmailListState();
  }
}
