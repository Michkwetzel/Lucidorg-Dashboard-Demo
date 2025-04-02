import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/createAssessment/current/current_active_email_list.dart';
import 'package:platform_front/lucid_ORG/components/createAssessment/emailList/emailListView/activeEmailListWidget.dart';
import 'package:platform_front/lucid_ORG/components/createAssessment/emailList/radioButton/radioButtonRow.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class CurrentEmaillistbody extends ConsumerWidget {
  const CurrentEmaillistbody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 600,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF555353), width: 0.7),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CurrentEmailListViewLayout(),
        ));
  }
}

class CurrentEmailListViewLayout extends ConsumerWidget {
  const CurrentEmailListViewLayout({
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
              'Emails the assessment was sent to',
              style: kInfoTextTextStyle,
            ),
            SizedBox(height: 12),
            RadioButtonRow(display: AssessmentDisplay.current,),
            SizedBox(height: 12),
            CurrentActiveEmailList(),
          ],
        ),
      ],
    );
  }
}
