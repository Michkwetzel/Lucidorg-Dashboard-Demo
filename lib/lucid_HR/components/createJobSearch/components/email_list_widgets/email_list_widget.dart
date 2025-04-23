import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/config/providers_hr.dart';
import 'package:platform_front/lucid_ORG/components/create_assessment/emailList/emailListView/emailCard.dart';

class EmailListWidget extends ConsumerWidget {
  const EmailListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> emailList = ref.watch(jobCreationProvider).emailList;

    return ListView.builder(
      itemCount: emailList.length,
      itemBuilder: (context, index) {
        return EmailCard(
          emailText: emailList[index],
          index: index,
          onDelete: () => ref.read(jobCreationProvider.notifier).removeEmail(index),
        );
      },
    );
  }
}
