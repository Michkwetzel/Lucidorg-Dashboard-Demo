import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class ArrowWidget extends ConsumerWidget {
  const ArrowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusSection selectedSection = ref.watch(focusSelectedSectionProvider);
    String direction = 'down';
    if (selectedSection == FocusSection.scorePyramid) {
      direction = 'up';
    }

    return SizedBox(
      height: 100,
      width: 30,
      child: CustomPaint(
        painter: ArrowPainter(direction: direction),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final String direction;
  ArrowPainter({required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    if (direction == 'up') {
      // Draw the arrow head
      final Path path = Path();
      path.moveTo(size.width / 2, 0);
      path.lineTo(0, 10);
      path.lineTo(size.width, 10);
      path.close();
      canvas.drawPath(path, paint);

      // Draw the arrow shaft
      canvas.drawRect(
        Rect.fromLTWH(size.width / 2 - 2, 0, 4, size.height - 10),
        paint,
      );
    } else {
      // Draw the arrow shaft
      canvas.drawRect(
        Rect.fromLTWH(size.width / 2 - 2, 0, 4, size.height - 10),
        paint,
      );

      // Draw the arrow head
      final Path path = Path();
      path.moveTo(0, size.height - 10);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, size.height - 10);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
