import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class ReminderTemplateView extends ConsumerWidget {
  const ReminderTemplateView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.zero,
        child: Text(
          ref.read(reminderEmailTemplateProvider.notifier).templateBody,
          style: const TextStyle(
            letterSpacing: 0.4,
            fontSize: 16.0,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
