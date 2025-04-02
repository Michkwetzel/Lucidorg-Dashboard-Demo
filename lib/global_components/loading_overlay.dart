import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';

class OverlayWidget extends ConsumerStatefulWidget {
  final Widget child;
  final bool showChild;
  final String loadingMessage;
  final bool loadingProvider;

  const OverlayWidget({
    this.loadingProvider = false,
    this.loadingMessage = 'Loading...',
    this.showChild = true,
    required this.child,
    super.key,
  });

  @override
  ConsumerState<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends ConsumerState<OverlayWidget> with SingleTickerProviderStateMixin {
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
    if (widget.loadingProvider) {
      // Widget is loading
      if (widget.showChild) {
        return Stack(
          children: [
            widget.child,
            AbsorbPointer(
              child: GestureDetector(
                // Optional: This ensures even transparent areas block touches
                behavior: HitTestBehavior.opaque,
                // Using onTap: (){} to ensure the GestureDetector is active
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            LoadingAnimation(animation: _animation, widget: widget)
          ],
        );
      } else {
        return LoadingAnimation(animation: _animation, widget: widget);
      }
    } else {
      return widget.child;
    }
  }
}

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
    required Animation<double> animation,
    required this.widget,
  }) : _animation = animation;

  final Animation<double> _animation;
  final OverlayWidget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
