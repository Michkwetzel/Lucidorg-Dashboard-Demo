import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/primaryButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/templateEdit.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/templateView.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Email Template", style: kH2TextStyle),
          SizedBox(height: 36),
          Flexible(
            child: isEditMode ? TemplateEdit() : const TemplateView(),
          ),
          const SizedBox(height: 32),
          _buildActionButton(ref, isEditMode),
        ],
      ),
    );
  }

  Widget _buildActionButton(WidgetRef ref, bool isEditMode) {
    return Align(
      alignment: Alignment.centerRight,
      child: isEditMode
          ? CallToActionButton(
              onPressed: () => ref.read(emailTemplateProvider.notifier).changeToViewEmailsDisplay(),
              buttonText: 'Save',
            )
          : Primarybutton(
              onPressed: () => ref.read(emailTemplateProvider.notifier).changeToEditEmailsDisplay(),
              buttonText: "Edit Email Template",
            ),
    );
  }
}
