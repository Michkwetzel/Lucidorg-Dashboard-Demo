import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListAdd/emailListAddLayout.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListView/emailListViewLayout.dart';
import 'package:platform_front/config/providers.dart';

class Emaillistbody extends ConsumerWidget {
  const Emaillistbody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF555353), width: 0.7),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(padding: const EdgeInsets.all(24.0), child: ref.watch(emailListProvider).addEmailDisplay ? Emaillistaddlayout() : EmailListViewLayout()),
    );
  }
}
