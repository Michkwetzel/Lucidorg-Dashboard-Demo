import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class EmailCard extends ConsumerWidget {
  final String emailText;
  final int index;
  final AssessmentDisplay display;

  const EmailCard({super.key, required this.emailText, required this.index, this.display = AssessmentDisplay.create});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFC3C3C3), width: 1))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4, top: 4, right: 8, left: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Text(
                emailText,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),
              ),
            ),
            if (display == AssessmentDisplay.create)
            IconButton(
              onPressed: () => ref.read(emailListProvider.notifier).deleteSingleEmail(index: index, type: ref.read(emailListRadioButtonProvider)),
              icon: const Icon(
                Icons.close,
                size: 20,
                color: Color(0xFFC3C3C3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
