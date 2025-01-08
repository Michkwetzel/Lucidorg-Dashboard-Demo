import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/primaryButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/templateEdit.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/templateView.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

final _formKey = GlobalKey<FormState>();

class EmailTemplateBody extends ConsumerWidget {
  const EmailTemplateBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(emailTemplateProvider.select((it) => it.editEmailTemplateDisplay));

    return Container(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 50, bottom: 16),
      decoration: isEditMode
          ? BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: 570,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Email Template", style: kH2TextStyle),
            SizedBox(height: 36),
            Flexible(
              child: isEditMode
                  ? TemplateEdit(
                      validator: (value) {
                        print(value);
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (!value.contains('[Assessment Link]') && !value.contains('[assessment link]')) {
                          return 'Email must contain "[assessment link]" (This is where link will be inserted)';
                        }
                        return null;
                      },
                    )
                  : const TemplateView(),
            ),
            const SizedBox(height: 32),
            _buildActionButton(ref, isEditMode),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(WidgetRef ref, bool isEditMode) {
    return Align(
      alignment: Alignment.centerRight,
      child: isEditMode
          ? CallToActionButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, proceed with save
                  print(_formKey.currentState!.validate());
                  ref.read(emailTemplateProvider.notifier).changeToViewEmailsDisplay();
                }
              },
              buttonText: 'Save',
            )
          : Primarybutton(
              onPressed: () => ref.read(emailTemplateProvider.notifier).changeToEditEmailsDisplay(),
              buttonText: "Edit Email Template",
            ),
    );
  }
}
