import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/subjectView.dart';
import 'package:platform_front/components/global/buttons/CallToActionButton.dart';
import 'package:platform_front/components/global/buttons/primaryButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/subjectEdit.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/templateEdit.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/templateView.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

final _formKey = GlobalKey<FormState>();

class EmailTemplateBody extends ConsumerWidget {
  const EmailTemplateBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(emailTemplateProvider.select((it) => it.editEmailTemplateDisplay));

    return Container(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
      decoration: isEditMode
          ? BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      constraints: BoxConstraints(
        maxWidth: 570,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditMode) SizedBox(height: 24),
            const Text("Email Template", style: kH2TextStyle),
            SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'From:',
                  style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 22, color: Color(0xFF323232)),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.zero,
              child: Text(
                'eric@Efficiency-first.com',
                style: const TextStyle(
                  letterSpacing: 0.4,
                  fontSize: 16.0,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Subject:',
              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 22, color: Color(0xFF323232)),
            ),
            SizedBox(height: 4),
            isEditMode
                ? SubjectEdit(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Subject';
                      }
                      return null;
                    },
                  )
                : const SubjectView(),
            SizedBox(height: 16),
            Text(
              'Body:',
              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 22, color: Color(0xFF323232)),
            ),
            SizedBox(height: 4),
            isEditMode
                ? BodyEmailTemplateEdit(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (!value.contains('[Assessment Link]') && !value.contains('[assessment link]')) {
                        return 'Email must contain "[assessment link]" (This is where link will be inserted)';
                      }
                      return null;
                    },
                  )
                : const TemplateView(),
            const SizedBox(height: 32),
            EditEmailTemplateBUtton(isEditMode: ref.watch(emailTemplateProvider.select((it) => it.editEmailTemplateDisplay))),
          ],
        ),
      ),
    );
  }
}

class EditEmailTemplateBUtton extends ConsumerWidget {
  const EditEmailTemplateBUtton({
    super.key,
    required this.isEditMode,
  });

  final bool isEditMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: isEditMode
          ? CallToActionButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(emailTemplateProvider.notifier).changeToViewTemplateDisplay();
                }
              },
              buttonText: 'Save',
            )
          : Primarybutton(
              onPressed: () => ref.read(emailTemplateProvider.notifier).changeToEditTemplateDisplay(),
              buttonText: "Edit Email Template",
            ),
    );
  }
}
