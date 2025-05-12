import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/email_template/body_email_template_edit.dart';
import 'package:platform_front/lucid_HR/components/global_components/heading_and_divider.dart';
import 'package:platform_front/lucid_HR/components/global_components/simple_text_field_gray.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class EmailTemplateWidget_ORG extends ConsumerWidget {
  const EmailTemplateWidget_ORG({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 12,
      children: [
        HeadingAndDivider(
          heading: "Email Template",
        ),
        SimpleTextFieldGray(
          formKey: ref.read(emailTemplateProvider.notifier).formKeys[0],
          heading: "Email From:",
          hintText: "John from My Company...",
          onTextChanged: (text) => ref.read(emailTemplateProvider.notifier).updateEmailFrom(text),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter an Email From";
            }
            return null;
          },
        ),
        SimpleTextFieldGray(
          formKey: ref.read(emailTemplateProvider.notifier).formKeys[1],
          heading: "Subject:",
          hintText: "You are invited to a ...",
          onTextChanged: (text) => ref.read(emailTemplateProvider.notifier).updateSubjectText(text),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter a Subject";
            }
            return null;
          },
        ),
        BodyEmailTemplateEdit(
          initialValue: ref.read(emailTemplateProvider.notifier).templateBody,
          onChanged: (value) => ref.read(emailTemplateProvider.notifier).updateEmailTemplate(value),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter some text";
            } else if (!text.contains('[Assessment Link]') && !text.contains('[assessment link]')) {
              return 'Please add "[assessment link]" in the email. (This is where link will be inserted)';
            }
            return null;
          },
        )
      ],
    );
  }
}
