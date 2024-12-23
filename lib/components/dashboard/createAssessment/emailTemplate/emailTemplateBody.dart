import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/primaryButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/templateEdit.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/templateView.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class Emailtemplatebody extends ConsumerWidget {
  const Emailtemplatebody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: 800,
            minWidth: 400, 
            maxWidth: 500// Minimum width
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Email Template",
                style: kH2TextStyle,
              ),
              const SizedBox(
                height: 36,
              ),
              Expanded(child: ref.watch(emailTemplateProvider.select((it) => it.editEmailTemplateDisplay)) ? TemplateEdit() : TemplateView()),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ref.watch(emailTemplateProvider.select((it) => it.editEmailTemplateDisplay))
                      ? CallToActionButton(
                          onPressed: () => ref.read(emailTemplateProvider.notifier).changeToViewEmailsDisplay(),
                          buttonText: 'Save',
                        )
                      : Primarybutton(onPressed: () => ref.read(emailTemplateProvider.notifier).changeToEditEmailsDisplay(), buttonText: "Edit Email Template"),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
