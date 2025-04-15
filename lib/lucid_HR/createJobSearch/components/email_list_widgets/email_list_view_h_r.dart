import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/buttons/primaryButton.dart';
import 'package:platform_front/global_components/buttons/secondaryButton.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/lucid_HR/config/providers.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/email_list_widgets/email_list_widget.dart';
import 'package:platform_front/lucid_HR/createJobSearch/job_creation_screen.dart';

class EmailListViewHR extends ConsumerWidget {
  const EmailListViewHR({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email List',
          style: kH2TextStyle,
        ),
        SizedBox(height: 12),
        CustomDivider(color: Colors.black, thickness: 1),
        SizedBox(height: 4),
        Expanded(child: EmailListWidget()),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Secondarybutton(onPressed: () => ref.read(jobCreationProvider.notifier).clearEmails(), buttonText: 'Clear'),
            Primarybutton(
                onPressed: () {
                  ref.read(jobCreationProvider.notifier).changeToAddEmailsDisplay();
                },
                buttonText: 'Add Emails'),
          ],
        )
      ],
    );
  }
}
