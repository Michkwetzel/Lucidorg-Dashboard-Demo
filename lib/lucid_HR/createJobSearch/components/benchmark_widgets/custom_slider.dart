import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_HR/config/providers.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class CustomSlider extends ConsumerWidget {
  final Indicator indicator;
  const CustomSlider({super.key, required this.indicator});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double sliderValue = ref.watch(jobCreationProvider.select((state) => state.benchmarks[indicator]!));

    return Row(
      children: [
        Text(
          "0%",
          style: TextStyle(fontFamily: "FS Pro Text", fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF8A8A8E)),
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: 100,
            activeColor: kSageGreen,
            value: sliderValue,
            thumbColor: Colors.white,
            onChanged: (value) {
              ref.read(jobCreationProvider.notifier).updateSliderValue(indicator, value);
            },
            label: sliderValue.toStringAsFixed(0),
          ),
        ),
        Text(
          "100%",
          style: TextStyle(fontFamily: "FS Pro Display", fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF8A8A8E)),
        ),
        SizedBox(width: 16),
        Container(
          width: 50,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: kSageGreen, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
              child: Text(
            sliderValue.toStringAsFixed(0),
            style: TextStyle(fontFamily: "FS Pro", fontSize: 14),
          )),
        )
      ],
    );
  }
}
