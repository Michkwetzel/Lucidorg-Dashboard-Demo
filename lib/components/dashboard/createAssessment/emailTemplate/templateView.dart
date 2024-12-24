import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/providers.dart';

class TemplateView extends ConsumerWidget {
  const TemplateView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container( // Add Container to match TextFormField's natural padding
        color: Colors.white, // Match TextFormField's background
        padding: EdgeInsets.zero, // Match TextFormField's padding
        child: Text(
          ref.read(emailTemplateProvider.notifier).templateBody,
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
