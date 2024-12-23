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
      child: 
      Text(
        ref.read(emailTemplateProvider.notifier).templateBody,
        style: const TextStyle(
          fontSize: 16.0,
          height: 1.5,
          color: Colors.black87,
        ),
      ),
    );
  }
}
