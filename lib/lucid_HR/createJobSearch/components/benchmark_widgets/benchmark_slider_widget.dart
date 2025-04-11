import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/benchmark_widgets/custom_slider.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class BenchmarkSliderWidget extends StatelessWidget {
  final String heading;
  final String extraText;
  final Indicator indicator;
  const BenchmarkSliderWidget({super.key, required this.heading, required this.extraText, required this.indicator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading, style: kH4PoppinsLight),
        CustomSlider(
          indicator: indicator,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(extraText, style: TextStyle(fontFamily: "FS Pro Text", letterSpacing: 0.6, fontSize: 13, fontWeight: FontWeight.w200)),
        ),
      ],
    );
  }
}
