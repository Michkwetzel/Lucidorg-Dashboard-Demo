import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class InfoDropDownWidget extends ConsumerStatefulWidget {
  const InfoDropDownWidget({
    super.key,
  });

  @override
  ConsumerState<InfoDropDownWidget> createState() => _InfoDropDownWidgetState();
}

class _InfoDropDownWidgetState extends ConsumerState<InfoDropDownWidget> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;

  @override
  Widget build(BuildContext context) {
    FocusSection selectedSection = ref.watch(focusSelectedSectionProvider);
    String q1Text = 'How do I fix differentiation?';
    String q2Text = 'Why top down?';
    String q3Text = 'Why Differentation first?';
    if (selectedSection == FocusSection.scorePyramid) {
      q1Text = 'How do I fix my Benchmarks?';
      q2Text = 'Why bottom up?';
      q3Text = 'Why organized in a pyramid?';
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => isExpanded1 = !isExpanded1),
          child: Row(
            children: [
              Text(q1Text, style: kH5PoppinsLight),
              Icon(
                Icons.arrow_drop_down,
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: isExpanded1 ? 100 : 0,
          child: Text('Navigate to the Fix section for everything you need', style: kH7PoppinsLight),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () => setState(() => isExpanded2 = !isExpanded2),
          child: Row(
            children: [
              Text(q2Text, style: kH5PoppinsLight),
              Icon(
                Icons.arrow_drop_down,
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: isExpanded2 ? 100 : 0,
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () => setState(() => isExpanded3 = !isExpanded3),
          child: Row(
            children: [
              Text(q3Text, style: kH5PoppinsLight),
              Icon(
                Icons.arrow_drop_down,
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: isExpanded3 ? 100 : 0,
          child: Text('...', style: kH7PoppinsLight),
        ),
      ],
    );
  }
}
