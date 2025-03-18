import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/global/buttons/primaryButton.dart';
import 'package:platform_front/components/global/buttons/secondaryButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListView/activeEmailListWidget.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/radioButton/radioButtonRow.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class EmailListViewLayout extends ConsumerWidget {
  const EmailListViewLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Email List',
              style: kH2TextStyle,
            ),
         
            SizedBox(height: 12),
            Text(
              'Select appropriate department',
              style: kInfoTextTextStyle,
            ),
            SizedBox(height: 12),
            RadioButtonRow(),
            SizedBox(height: 12),
            ActiveEmailListWidget(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Secondarybutton(onPressed: () => ref.read(emailListProvider.notifier).deleteGroupEmails(ref.watch(emailListRadioButtonProvider)), buttonText: 'Clear'),
            Primarybutton(onPressed: () => ref.read(emailListProvider.notifier).changeToAddEmailsDisplay(), buttonText: 'Add Emails'),
          ],
        )
      ],
    );
  }
}
