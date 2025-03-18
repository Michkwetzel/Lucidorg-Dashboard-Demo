import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/providers.dart';

class ReminderSubjectView extends ConsumerWidget {
  const ReminderSubjectView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.zero,
      child: Text(
        ref.read(reminderEmailTemplateProvider.notifier).subject,
        style: const TextStyle(
          letterSpacing: 0.4,
          fontSize: 16.0,
          height: 1.5,
          color: Colors.black87,
        ),
      ),
    );
  }
}
