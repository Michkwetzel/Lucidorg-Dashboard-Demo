import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/assessment/emailList/emailListView/emailCard.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class CurrentActiveEmailList extends ConsumerWidget {
  const CurrentActiveEmailList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the selected email list type and the active email list
    final emailListSelected = ref.watch(emailListRadioButtonProvider);
    final activeEmailList = ref.watch(currentEmailListProvider);

    // Determine the correct list and item count based on selection
    List<String> selectedEmailList;
    switch (emailListSelected) {
      case EmailListRadioButtonType.ceo:
        selectedEmailList = activeEmailList.emailsCeo;
        break;
      case EmailListRadioButtonType.cSuite:
        selectedEmailList = activeEmailList.emailsCSuite;
        break;
      case EmailListRadioButtonType.employee:
      default:
        selectedEmailList = activeEmailList.emailsEmployee;
        break;
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        itemCount: selectedEmailList.length,
        itemBuilder: (context, index) {
          return EmailCard(
            emailText: selectedEmailList[index],
            index: index,
            display: AssessmentDisplay.current,
          );
        },
      ),
    );
  }
}
