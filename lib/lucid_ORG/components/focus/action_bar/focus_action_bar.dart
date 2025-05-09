import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/focus/action_bar/focus_action_bar_button.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class FocusActionBar extends ConsumerWidget {
  const FocusActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusSection selectedSection = ref.watch(focusSelectedSectionProvider);

    String heading = 'Step 1 - Differentiation';
    if (selectedSection == FocusSection.scorePyramid) {
      heading = 'Step 2 - Benchmarks';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.w600, fontSize: 30, color: Color(0xFF494949)),
        ),
        Row(
          spacing: 32,
          children: [
            FocusActionBarButton(buttonText: 'Step 1', section: FocusSection.diffPyramid),
            FocusActionBarButton(buttonText: 'Step 2', section: FocusSection.scorePyramid),
          ],
        )
      ],
    );
  }
}
