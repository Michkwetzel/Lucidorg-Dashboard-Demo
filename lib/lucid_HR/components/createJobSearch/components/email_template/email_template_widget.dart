import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/config/providers_hr.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/email_template/body_email_template_edit.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/job_creation_screen.dart';
import 'package:platform_front/lucid_HR/components/global_components/heading_and_divider.dart';
import 'package:platform_front/lucid_HR/components/global_components/simple_text_field_gray.dart';

class EmailTemplateWidget extends ConsumerWidget {
  const EmailTemplateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 12,
      children: [
        HeadingAndDivider(
          heading: "Benchmarks",
        ),
        SimpleTextFieldGray(
          formKey: ref.read(jobCreationProvider.notifier).formKeys[1],
          heading: "Email From:",
          hintText: "John from My Company...",
          onTextChanged: (text) => ref.read(jobCreationProvider.notifier).updateEmailFrom(text),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter an Email From";
            }
            return null;
          },
        ),
        SimpleTextFieldGray(
          formKey: ref.read(jobCreationProvider.notifier).formKeys[2],
          heading: "Subject:",
          hintText: "You are invited to a ...",
          onTextChanged: (text) => ref.read(jobCreationProvider.notifier).updateEmailSubject(text),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter a Subject";
            }
            return null;
          },
        ),
        BodyEmailTemplateEdit(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter some text";
            }
            return null;
          },
        )
      ],
    );
  }
}
