import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/constants.dart';

class LoadingOverlay extends ConsumerStatefulWidget {
  final Widget child;
  final bool showChild;
  final String loadingMessage;
  final bool loadingProvider;
  const LoadingOverlay({
    required this.loadingProvider,
    this.loadingMessage = 'Loading...',
    this.showChild = true,
    required this.child,
    super.key,
  });

  @override
  ConsumerState<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends ConsumerState<LoadingOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Total animation duration
      vsync: this,
    )..repeat();

    // Create a custom curve for the spinning animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ).drive(
      Tween<double>(
        begin: 0,
        end: 1,
      ).chain(
        TweenSequence([
          TweenSequenceItem(
            tween: Tween<double>(begin: 0, end: 2) // Fast clockwise spin (2 rotations)
                .chain(CurveTween(curve: Curves.easeOut)),
            weight: 40,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 2, end: 1.5) // Slower counterclockwise (half rotation back)
                .chain(CurveTween(curve: Curves.easeInOut)),
            weight: 60,
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showChild) {
      return Stack(
        children: [
          widget.child,
          if (widget.loadingProvider)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: RotationTransition(
                      turns: _animation,
                      child: Image.asset(
                        'assets/logo/3transparent_logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: kboxShadowNormal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    child: Text(
                      widget.loadingMessage,
                      style: kH5PoppinsLight,
                    ),
                  ),
                )
              ],
            )
        ],
      );
    } else {
      if (widget.loadingProvider) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white.withOpacity(0.8),
              child: Center(
                child: RotationTransition(
                  turns: _animation,
                  child: Image.asset(
                    'assets/logo/logoImage.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Loading...',
              style: kH5PoppinsLight,
            )
          ],
        );
      } else {
        return widget.child;
      }
    }
  }
}
