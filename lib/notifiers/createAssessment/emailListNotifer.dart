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
          emailsCeo: ["dsoo@gmail.com", "saadsrk@gmail.com"],
          emailsCSuite: ["devinAndrews@gmail.com", "mark@gmail.com", "random@gmail.com", "mark@gmail.com", "jason@gmail.com", "mark@gmail.com", "jasmin@gmail.com"],
          emailsEmployee: ["michkwetzel@gmail.com", "jason@gmail.com", "mark@gmail.com", "sarahhuissteenshsbdhsbdhsbdhsbhdbshbdhsbdbhbdhs@gmail.com", "jasmin@gmail.com"],
        ));

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

  int listLength(EmailListRadioButtonType type){
    switch (type) {
      case EmailListRadioButtonType.cSuite:
        return state.emailsCSuite.length;
      case EmailListRadioButtonType.ceo:
        return state.emailsCeo.length;
      case EmailListRadioButtonType.employee:
        return state.emailsEmployee.length;
      default:
        return 0;
    }
  }

  void deleteAllEmails() {
    state = state.copyWith(emailsCSuite: [], emailsCeo: [], emailsEmployee: []);
  }

  void changeToAddEmailsDisplay(){
    state = state.copyWith(addEmailDisplay: true);
  }
  void changeToViewEmailsDisplay(){
    state = state.copyWith(addEmailDisplay: false);
  }
}
