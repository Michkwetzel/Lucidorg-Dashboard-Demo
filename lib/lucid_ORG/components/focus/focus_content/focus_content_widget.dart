import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/lucid_ORG/components/focus/focus_content/components/arrow_painter.dart';
import 'package:platform_front/lucid_ORG/components/focus/focus_content/focus_area/focus_areas_widget.dart';
import 'package:platform_front/lucid_ORG/components/focus/focus_content/components/info_drop_down_widget.dart';
import 'package:platform_front/lucid_ORG/components/focus/pyramid/pyramid_widget.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class FocusContentWidget extends StatelessWidget {
  const FocusContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: 16),
        // CustomDivider(),
        SizedBox(height: 32),
        TopTextWidget(),
        Stack(
          children: [
            Row(
              children: [
                SizedBox(width: 60),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: FocusAreasWidget(),
                ),
                SizedBox(width: 40),
                PyramidWidget(),
              ],
            ),
            Positioned(
              left: 620,
              top: 20,
              child: PyramidInfoWidget(),
            ),
          ],
        ),
        InfoDropDownWidget(),
      ],
    );
  }
}

class PyramidInfoWidget extends ConsumerWidget {
  const PyramidInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusSection selectedSection = ref.watch(focusSelectedSectionProvider);
    String text = 'The indicators are stacked in a pyramid style with descending Priority';
    if (selectedSection == FocusSection.scorePyramid) {
      text = "For score work in the opposite direction. Start from the bottom layer and work up";
    }

    return SizedBox(
      width: 200,
      child: Row(
        children: [
          Flexible(
            child: Column(
              spacing: 8,
              children: [
                Text(
                  text,
                  style: kH6PoppinsLight.copyWith(fontSize: 16),
                ),
                Row(
                  children: [
                    if (selectedSection == FocusSection.diffPyramid)
                      SvgPicture.asset(
                        'assets/icons/trianlge.svg',
                        width: 22,
                        height: 22,
                        colorFilter: ColorFilter.mode(Color(0xFF3F3F3F), BlendMode.srcIn),
                      ),
                    Text(
                      selectedSection == FocusSection.diffPyramid ? '= Differentiation' : '% = percent score',
                      style: kH6PoppinsLight.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ArrowWidget(),
        ],
      ),
    );
  }
}

class TopTextWidget extends ConsumerWidget {
  const TopTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusSection selectedSection = ref.watch(focusSelectedSectionProvider);
    String text = 'First, focus on the widest differentiation from the top down';
    if (selectedSection == FocusSection.scorePyramid) {
      text = "Secondly, focus on the Lowest score from the bottom up";
    }
    return Text(text, style: kH5PoppinsLight);
  }
}
