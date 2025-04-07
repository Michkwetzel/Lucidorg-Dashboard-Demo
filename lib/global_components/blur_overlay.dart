import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';

class BlurOverlay extends StatelessWidget {
  final Widget child;
  final bool blur;
  final String? message;
  const BlurOverlay({super.key, required this.child, this.blur = false, this.message});

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
          if (message != null)
            Center(
              child: Container(
                decoration: kboxShadowNormal,
                child: Padding(
                  padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 16),
                  child: Text(
                    message!,
                    style: kH4PoppinsRegular,
                  ),
                ),
              ),
            )
        ],
      );
    } else {
      return child;
    }
  }
}
