import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReminderEmailTemplateState {
  final bool editEmailTemplateDisplay;
  final String templateBody;
  final TextEditingController templateController;
  final String subject;

  ReminderEmailTemplateState({required this.templateController, this.editEmailTemplateDisplay = false, this.templateBody = '', this.subject = 'Reminder to complete survey'});

  ReminderEmailTemplateState copyWith({bool? editEmailTemplateDisplay, String? templateBody, TextEditingController? templateController, String? subject}) {
    return ReminderEmailTemplateState(
      templateController: templateController ?? this.templateController,
      editEmailTemplateDisplay: editEmailTemplateDisplay ?? this.editEmailTemplateDisplay,
      templateBody: templateBody ?? this.templateBody,
      subject: subject ?? this.subject,
    );
  }

  factory ReminderEmailTemplateState.initial() {
    return ReminderEmailTemplateState(
        templateController: TextEditingController(),
        templateBody:
            "Hi Team!\n\nPlease would you help us become a better company by filling in the survey. Note that this is a reminder!\n\n[assessment link]\n\nThanks for making this happen,\nLeadership Team");
  }
}

class ReminderEmailTemplateNotifer extends StateNotifier<ReminderEmailTemplateState> {
  ReminderEmailTemplateNotifer() : super(ReminderEmailTemplateState.initial());

  String get templateBody => state.templateBody;
  String get subject => state.subject;
  bool get editEmailTemplateDisplay => state.editEmailTemplateDisplay;

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
}
