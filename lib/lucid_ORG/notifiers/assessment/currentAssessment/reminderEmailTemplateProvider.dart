import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReminderEmailTemplateState {
  final String templateBody;
  final TextEditingController templateController;
  final String subject;
  final String emailFrom;
  final List<GlobalKey<FormState>> formKeys; //1 form keys for 1 textfields. for validation

  ReminderEmailTemplateState({required this.templateController, this.templateBody = '', this.subject = 'Reminder to complete survey', required this.formKeys, required this.emailFrom});

  ReminderEmailTemplateState copyWith(
      {bool? editEmailTemplateDisplay, String? templateBody, TextEditingController? templateController, String? subject, List<GlobalKey<FormState>>? formKeys, String? emailFrom}) {
    return ReminderEmailTemplateState(
      emailFrom: emailFrom ?? this.emailFrom,
      templateController: templateController ?? this.templateController,
      templateBody: templateBody ?? this.templateBody,
      subject: subject ?? this.subject,
      formKeys: formKeys ?? this.formKeys,
    );
  }

  factory ReminderEmailTemplateState.initial() {
    return ReminderEmailTemplateState(
      emailFrom: "",
        formKeys: [
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
        ],
        templateController: TextEditingController(),
        templateBody:
            "Hi Team!\n\nPlease would you help us become a better company by filling in the survey. Note that this is a reminder!\n\n[assessment link]\n\nThanks for making this happen,\nLeadership Team");
  }
}

class ReminderEmailTemplateNotifer extends StateNotifier<ReminderEmailTemplateState> {
  ReminderEmailTemplateNotifer() : super(ReminderEmailTemplateState.initial());

  String get templateBody => state.templateBody;
  String get subject => state.subject;
  List<GlobalKey<FormState>> get formKeys => state.formKeys;

  void changeToEditEmailsDisplay() {
    state = state.copyWith(editEmailTemplateDisplay: true);
  }

  void changeToViewEmailsDisplay() {
    state = state.copyWith(editEmailTemplateDisplay: false);
  }

  void updateEmailTemplate(String text) {
    state = state.copyWith(templateBody: text);
  }

  void updateSubjectText(String text) {
    state = state.copyWith(subject: text);
  }

  void updateEmailFrom(String text) {
    state = state.copyWith(emailFrom: text);
  }

  bool validateAllData() {
    bool flag = true;

    print("Start Validated data");

    for (var formKey in state.formKeys) {
      if (!formKey.currentState!.validate()) {
        flag = false;
      }
    }
    print("Validated data");
    return flag;
  }
}
