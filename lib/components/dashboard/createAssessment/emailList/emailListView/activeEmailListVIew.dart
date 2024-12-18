import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListView/emailCard.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class ActiveEmailListView extends ConsumerWidget {
  const ActiveEmailListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the selected email list type and the active email list
    final emailListSelected = ref.watch(emailListRadioButtonProvider);
    final activeEmailList = ref.watch(emailListProvider);

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
      height: 300,
      child: ListView.builder(
        itemCount: selectedEmailList.length,
        itemBuilder: (context, index) {
          return EmailCard(emailText: selectedEmailList[index], index: index);
        },
      ),
    );
  }
}
