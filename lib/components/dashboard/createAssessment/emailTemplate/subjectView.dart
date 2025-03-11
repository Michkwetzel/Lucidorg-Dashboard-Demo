import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/providers.dart';

class SubjectView extends ConsumerWidget {
  const SubjectView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.zero,
      child: Text(
        ref.read(emailTemplateProvider.notifier).subject,
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
