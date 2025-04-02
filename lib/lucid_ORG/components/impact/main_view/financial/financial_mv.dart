import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/global_components/grayDivider.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class FinancialMv extends StatelessWidget {
  const FinancialMv({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Financial', style: kH3PoppinsMedium),
          SizedBox(height: 6),
          GrayDivider(),
          SizedBox(height: 32),
          Text('Move sliders to see effect of increasing scores over time', style: kH5PoppinsLight),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 488,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0%', style: TextStyle(color: Colors.black54, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
                      Text('20%', style: TextStyle(color: Colors.black54, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
                      Text('40%', style: TextStyle(color: Colors.black54, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
                      Text('60%', style: TextStyle(color: Colors.black54, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
                      Text('80%', style: TextStyle(color: Colors.black54, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
                      Text('100%', style: TextStyle(color: Colors.black54, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: 16,
            children: [
              HeadingSliderWidget(indicator: Indicator.orgAlign),
              HeadingSliderWidget(indicator: Indicator.growthAlign),
              HeadingSliderWidget(indicator: Indicator.collabKPIs),
              HeadingSliderWidget(indicator: Indicator.engagedCommunity),
              HeadingSliderWidget(indicator: Indicator.crossFuncComms),
              HeadingSliderWidget(indicator: Indicator.crossFuncAcc),
              HeadingSliderWidget(indicator: Indicator.alignedTech),
              HeadingSliderWidget(indicator: Indicator.collabProcesses),
              HeadingSliderWidget(indicator: Indicator.meetingEfficacy),
              HeadingSliderWidget(indicator: Indicator.purposeDriven),
              HeadingSliderWidget(indicator: Indicator.empoweredLeadership),
            ],
          )
        ],
      ),
    );
  }
}

class HeadingSliderWidget extends ConsumerStatefulWidget {
  final double value;
  final Indicator indicator;
  const HeadingSliderWidget({super.key, required this.indicator, this.value = 20});

  @override
  ConsumerState<HeadingSliderWidget> createState() => _HeadingSliderWidgetState();
}

class _HeadingSliderWidgetState extends ConsumerState<HeadingSliderWidget> {
  late double sliderValue;

  @override
  void initState() {
    sliderValue = ref.read(financeModelProvider.notifier).getCurrentValue(widget.indicator)*100;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            widget.indicator.heading,
            style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Slider(
              activeColor: Color(0xFFB9D08F),
              label: sliderValue.toString(),
              divisions: 5,
              value: sliderValue,
              min: 0,
              max: 100,
              onChanged: (value) {
                ref.read(financeModelProvider.notifier).sliderChange(widget.indicator, value / 100);
                setState(() {
                  sliderValue = value;
                });
              }),
        ),
      ],
    );
  }
}
