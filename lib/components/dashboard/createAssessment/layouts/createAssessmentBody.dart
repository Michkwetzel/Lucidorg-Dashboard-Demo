import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListBody.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/emailTemplateBody.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class CreateAssessmentBody extends ConsumerWidget {
  CreateAssessmentBody({
    super.key,
  });

  final Logger logger = Logger('CreateAssessment');

  void startAssessment(BuildContext context, WidgetRef ref) async {
    if (ref.read(emailTemplateProvider.notifier).editEmailTemplateDisplay) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Save Email Template'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (ref.read(emailListProvider.notifier).emailsEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email list Empty'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (ref.read(companyInfoProvider.notifier).companyInfoEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter details in Company Info Page'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        await ref.read(googlefunctionserviceProvider.notifier).createAssessment();
        SnackBarService.showMessage('Successfully Created assessment', Colors.green);
      } on Exception catch (e) {
        SnackBarService.showMessage('Error creating Assessment', Colors.red);
        logger.severe("Failed to create Assessment with error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 380,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fixed header section
                const SizedBox(height: 12),
                const Text(
                  'Create Assessment',
                  style: kH1TextStyle,
                ),
                const SizedBox(height: 40),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Emaillistbody(),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CallToActionButton(
                              onPressed: () => startAssessment(context, ref),
                              buttonText: "Start Assessment",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          const Padding(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            child: EmailTemplateBody(),
          ),
        ],
      ),
    );
  }
}
