import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailTemplateState {
  final String templateBody;
  final TextEditingController templateController;
  final String subject;
  final String emailFrom;
  final List<GlobalKey<FormState>> formKeys; //1 form keys for 1 textfields. for validation

  EmailTemplateState({
    required this.emailFrom,
    required this.templateController,
    required this.formKeys,
    this.templateBody = '',
    this.subject = 'We Promise, This Survey Isn’t Just for Show',
  });

  EmailTemplateState copyWith(
      {String? emailFrom, bool? editEmailTemplateDisplay, String? templateBody, TextEditingController? templateController, String? subject, List<GlobalKey<FormState>>? formKeys}) {
    return EmailTemplateState(
      emailFrom: emailFrom ?? this.emailFrom,
      templateController: templateController ?? this.templateController,
      templateBody: templateBody ?? this.templateBody,
      subject: subject ?? this.subject,
      formKeys: formKeys ?? this.formKeys,
    );
  }

  factory EmailTemplateState.initial() {
    return EmailTemplateState(
        formKeys: [
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
        ],
        emailFrom: "LucidORG",
        templateController: TextEditingController(),
        templateBody:
            "Hi Team,\n\nLet’s be honest—no one loves surveys. But this one? It’s different.\n\nThis 10-15 minute completely anonymous assessment isn’t about collecting data to ignore later. It’s about uncovering what’s working, what’s not, and actually doing something about it.\nYour input will help spotlight hidden challenges and opportunities so we can turn insights into actions that matter. And no, “have more meetings about meetings” isn’t on the agenda.\n\nThe sooner you share your perspective, the sooner we can start making this place even better.\n\n[assessment link]\n\nThanks for making this happen,\nLeadership Team");
  }
}

class EmailTemplateNotifer extends StateNotifier<EmailTemplateState> {
  EmailTemplateNotifer() : super(EmailTemplateState.initial());

  String get templateBody => state.templateBody;
  String get subject => state.subject;
  String get emailFrom => state.emailFrom;
  List<GlobalKey<FormState>> get formKeys => state.formKeys;

  void changeToEditTemplateDisplay() {
    state = state.copyWith(editEmailTemplateDisplay: true);
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
