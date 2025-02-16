import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:platform_front/components/buttons/secondaryButton.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/services/microServices/navigationService.dart';

class OverlayWidget extends ConsumerStatefulWidget {
  final Widget child;
  final bool showChild;
  final String loadingMessage;
  final bool loadingProvider;
  final bool notEnoughData;
  final bool noSurveyData;

  const OverlayWidget({
    this.loadingProvider = false,
    this.loadingMessage = 'Loading...',
    this.showChild = true,
    this.noSurveyData = false,
    this.notEnoughData = false,
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
          children: [widget.child, LoadingAnimation(animation: _animation, widget: widget)],
        );
      } else {
        return LoadingAnimation(animation: _animation, widget: widget);
      }
    } else {
      // Widget is loading. check for no survey data or not enough survey data
      if (widget.noSurveyData) {
        return Stack(
          children: [
            widget.child,
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                  child: Container(
                    color: Colors.white.withOpacity(0.1), // This is crucial
                  ),
                ),
              ),
            ),
            NoSurveyDataWidget(),
          ],
        );
      }

      return widget.child;
    }
  }
}

class NoSurveyDataWidget extends ConsumerWidget {
  const NoSurveyDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 300,
      left: 300,
      child: Container(
        width: 460,
        height: 180,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No Assessment Available.\nDisplayed is Dummy data.',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 24, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Secondarybutton(
                      onPressed: () {
                        NavigationService.navigateTo('/createAssessment');
                      },
                      buttonText: "Create Assessment"),
                  Secondarybutton(
                      onPressed: () {
                        ref.read(metricsDataProvider.notifier).toggleDisplayDummyData();
                      },
                      buttonText: "View Dummy Results")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


class NotEnoughDataWidget extends ConsumerWidget {
  const NotEnoughDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 300,
      left: 300,
      child: Container(
        width: 460,
        height: 180,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Participation is <30%',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 24, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Secondarybutton(
                      onPressed: () {
                        NavigationService.navigateTo('/createAssessment');
                      },
                      buttonText: "Create Assessment"),
                  Secondarybutton(
                      onPressed: () {
                        ref.read(metricsDataProvider.notifier).toggleDisplayDummyData();
                      },
                      buttonText: "View Dummy Results")
                ],
              )
            ],
          ),
        ),
      ),
    );
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
