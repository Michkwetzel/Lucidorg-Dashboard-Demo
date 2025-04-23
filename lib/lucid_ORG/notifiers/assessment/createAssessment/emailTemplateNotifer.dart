import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailTemplateState {
  final bool editEmailTemplateDisplay;
  final String templateBody;
  final TextEditingController templateController;
  final String subject;
  final String emailFrom;

  EmailTemplateState({required this.emailFrom,required this.templateController, this.editEmailTemplateDisplay = false, this.templateBody = '', this.subject = 'We Promise, This Survey Isn’t Just for Show'});

  EmailTemplateState copyWith({String? emailFrom, bool? editEmailTemplateDisplay, String? templateBody, TextEditingController? templateController, String? subject}) {
    return EmailTemplateState(
      emailFrom: emailFrom ?? this.emailFrom,
      templateController: templateController ?? this.templateController,
      editEmailTemplateDisplay: editEmailTemplateDisplay ?? this.editEmailTemplateDisplay,
      templateBody: templateBody ?? this.templateBody,
      subject: subject ?? this.subject,
    );
  }

  factory EmailTemplateState.initial() {
    return EmailTemplateState(
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
  bool get editEmailTemplateDisplay => state.editEmailTemplateDisplay;
  String get emailFrom => state.emailFrom;

  void changeToEditTemplateDisplay() {
    state = state.copyWith(editEmailTemplateDisplay: true);
  }

  void changeToViewTemplateDisplay() {
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

}
