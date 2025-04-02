import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/createAssessment/current/reminder_subject_edit.dart';
import 'package:platform_front/lucid_ORG/components/createAssessment/current/reminder_subject_view.dart';
import 'package:platform_front/lucid_ORG/components/createAssessment/current/reminder_template_edit.dart';
import 'package:platform_front/lucid_ORG/components/createAssessment/current/reminder_template_view.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/global_components/buttons/primaryButton.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/services/microServices/alertService.dart';

final _formKey = GlobalKey<FormState>();

class ReminderEmailTemplateBody extends ConsumerWidget {
  const ReminderEmailTemplateBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(reminderEmailTemplateProvider.select((it) => it.editEmailTemplateDisplay));

    return Container(
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
            const Text("Reminder Email Template", style: kH2TextStyle),
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
                ? ReminderSubjectEdit(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Subject';
                      }
                      return null;
                    },
                  )
                : const ReminderSubjectView(),
            SizedBox(height: 16),
            Text(
              'Body:',
              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 22, color: Color(0xFF323232)),
            ),
            SizedBox(height: 4),
            isEditMode
                ? ReminderTemplateEdit(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (!value.contains('[Assessment Link]') && !value.contains('[assessment link]')) {
                        return 'Email must contain "[assessment link]" (This is where link will be inserted)';
                      }
                      return null;
                    },
                  )
                : const ReminderTemplateView(),
            const SizedBox(height: 32),
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ReminderEditEmailTemplateButton(),
                CallToActionButton(
                    onPressed: ref.read(userDataProvider.notifier).permission == Permission.guest
                        ? null
                        : () {
                            if (ref.read(reminderEmailTemplateProvider.notifier).editEmailTemplateDisplay) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please Save Email Template'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              ref.read(googlefunctionserviceProvider.notifier).sendEmailReminder();
                              AlertService.showAlert(title: 'Sent Reminder', message: "A reminder with the survey link has been sent");
                            }
                          },
                    buttonText: 'Send Reminder'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReminderEditEmailTemplateButton extends ConsumerWidget {
  const ReminderEditEmailTemplateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: ref.watch(reminderEmailTemplateProvider.select((it) => it.editEmailTemplateDisplay))
          ? CallToActionButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(reminderEmailTemplateProvider.notifier).changeToViewEmailsDisplay();
                }
              },
              buttonText: 'Save',
            )
          : Primarybutton(
              onPressed: () => ref.read(reminderEmailTemplateProvider.notifier).changeToEditEmailsDisplay(),
              buttonText: "Edit Reminder Template",
            ),
    );
  }
}
