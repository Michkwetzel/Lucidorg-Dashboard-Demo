import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/global_components/buttons/secondaryButton.dart';
import 'package:platform_front/lucid_HR/config/enums_hr.dart';
import 'package:platform_front/lucid_HR/config/providers.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class CreateJobButtonsWidget extends ConsumerWidget {
  const CreateJobButtonsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(jobCreationProvider).newJobSearchSection == NewJobSearchSection.chooseBenchmarks) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CallToActionButton(
            onPressed: () => ref.read(jobCreationProvider.notifier).onNextClicked(),
            buttonText: "Next",
          ),
        ],
      );
    } else {
      return Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Secondarybutton(
            onPressed: () => ref.read(jobCreationProvider.notifier).onBackClicked(),
            buttonText: "Back",
          ),
          CallToActionButton(
            onPressed: () async {
              final BuildContext dialogContext = context;
              if (ref.read(jobCreationProvider.notifier).validateAllData()) {
                showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  context: dialogContext,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Center(
                        child: LogoSpinAnimation(),
                      ),
                    );
                  },
                );
                await ref.read(googlefunctionserviceProvider.notifier).createNewJobSearch(ref.read(jobCreationProvider.notifier).getAllData()).then(
                  (value) {
                    if (dialogContext.mounted) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    SnackBarService.showMessage("Successfully Created Job Search", Colors.green);
                  },
                );
              }
            },
            buttonText: "Create Job Search",
          )
        ],
      );
    }
  }
}

class LogoSpinAnimation extends StatefulWidget {
  final String message;
  const LogoSpinAnimation({super.key, this.message = "Loading..."});

  @override
  State<LogoSpinAnimation> createState() => _LogoSpinAnimationState();
}

class _LogoSpinAnimationState extends State<LogoSpinAnimation> with SingleTickerProviderStateMixin {
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
        TweenSequence(
          [
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

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
              widget.message,
              style: kH5PoppinsLight,
            ),
          ),
        )
      ],
    );
  }
}
