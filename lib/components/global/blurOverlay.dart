import 'dart:ui';

import 'package:flutter/material.dart';

class BlurOverlay extends StatelessWidget {
  final Widget child;
  final bool blur;
  const BlurOverlay({super.key, required this.child, this.blur = false});

  @override
  Widget build(BuildContext context) {
    if (blur) {
      return Stack(
        children: [
          child,
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.white.withOpacity(0.1), // This is crucial
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return child;
    }
  }
}
