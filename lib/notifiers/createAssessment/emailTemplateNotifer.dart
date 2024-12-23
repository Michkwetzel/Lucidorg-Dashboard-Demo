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
          "To whom this may concern\n\nWe're excited to announce that we're \n\n\n\n\npartnering with Efficiency First to take a closer look at how we can improve as an organization.\n\nThe survey is 10-15 minutes, and completely anonymous. What makes this unique is that the results won't just sit on a shelf—we're using your input to create bottom-up solutions that empower each of you to take part in driving improvements across the company.\n\nThis is your chance to help identify the real issues, and more importantly, to be part of the solution. After the survey, we'll be sharing the results to work together on growth opportunities and problem-solving.\n\nHere [insert survey link] is the link to the survey. We ask that you complete it honestly within 24 hours, and please keep in mind that it is completely anonymous.\n\nYour insights will play a key role in helping us build a better, more efficient workplace where every voice contributes to our success.\n\nKind Regards\nTest Company",
    );
  }
}

class Emailtemplatenotifer extends StateNotifier<EmailTemplateState> {
  Emailtemplatenotifer() : super(EmailTemplateState.initial());

  String get templateBody => state.templateBody;

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
