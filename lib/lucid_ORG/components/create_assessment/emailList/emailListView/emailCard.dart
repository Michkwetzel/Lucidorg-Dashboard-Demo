import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class EmailCard extends StatelessWidget {
  final String emailText;
  final int index;
  final AssessmentDisplay display;
  final VoidCallback? onDelete;

  const EmailCard({super.key, required this.emailText, required this.index, this.display = AssessmentDisplay.create, this.onDelete});

  @override
  Widget build(BuildContext context) {
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
              onPressed: onDelete,
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
