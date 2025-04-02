import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class LegendItem extends ConsumerWidget {
  final Color color;
  final Department department;

  const LegendItem({super.key, required this.color, required this.department});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      onPressed: () => ref.read(selectedDepartmentDiffMatrixNotiferProvider.notifier).changeDepartmentSelected(department),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Colors.black45, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              department.heading,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
