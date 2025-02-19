import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailTemplateState {
  final bool editEmailTemplateDisplay;
  final String templateBody;
  final TextEditingController templateController;

  EmailTemplateState({required this.templateController, this.editEmailTemplateDisplay = false, this.templateBody = ''});

  EmailTemplateState copyWith({
    bool? editEmailTemplateDisplay,
    String? templateBody,
    TextEditingController? templateController,
  }) {
    return EmailTemplateState(
      templateController: templateController ?? this.templateController,
      editEmailTemplateDisplay: editEmailTemplateDisplay ?? this.editEmailTemplateDisplay,
      templateBody: templateBody ?? this.templateBody,
    );
  }

  factory EmailTemplateState.initial() {
    return EmailTemplateState(
        templateController: TextEditingController(),
        templateBody:
            "Hi Team,\n\nLet’s be honest—no one loves surveys. But this one? It’s different.\n\nThis 10-15 minute completely anonymous assessment isn’t about collecting data to ignore later. It’s about uncovering what’s working, what’s not, and actually doing something about it.\nYour input will help spotlight hidden challenges and opportunities so we can turn insights into actions that matter. And no, “have more meetings about meetings” isn’t on the agenda.\n\nThe sooner you share your perspective, the sooner we can start making this place even better.\n\n[assessment link]\n\nThanks for making this happen,\n[Your Name/Leadership Team]");
  }
}

class EmailTemplateNotifer extends StateNotifier<EmailTemplateState> {
  EmailTemplateNotifer() : super(EmailTemplateState.initial());

  String get templateBody => state.templateBody;
  bool get editEmailTemplateDisplay => state.editEmailTemplateDisplay;

  void changeToEditEmailsDisplay() {
    state = state.copyWith(editEmailTemplateDisplay: true);
  }

  void changeToViewEmailsDisplay() {
    state = state.copyWith(editEmailTemplateDisplay: false);
  }

  void updateTemplateText(String text) {
    state = state.copyWith(templateBody: text);
  }
}
