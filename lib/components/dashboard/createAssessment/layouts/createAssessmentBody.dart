import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/primaryButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListBody.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/emailTemplateBody.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class CreateAssessmentBody extends ConsumerWidget {
  const CreateAssessmentBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 380,
                  maxHeight: constraints.maxHeight, // Using the constraint's maxHeight
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      'Create Assessment',
                      style: kH1TextStyle,
                    ),
                    const SizedBox(height: 40),
                    const Emaillistbody(),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CallToActionButton(
                          onPressed: () {},
                          buttonText: "Start Assessment",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Emailtemplatebody(),
            ],
          ),
        );
      },
    );
  }
}
