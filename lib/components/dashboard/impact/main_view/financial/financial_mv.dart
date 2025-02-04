import 'package:flutter/material.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';

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
          HeadingSliderWidget(heading: 'Org Alignment'),
          SizedBox(height: 16),
          HeadingSliderWidget(heading: 'Growth Alignment'),
          SizedBox(height: 16),
          HeadingSliderWidget(heading: 'Collaborative KPI'),
          SizedBox(height: 16),
          HeadingSliderWidget(heading: 'Engaged Community'),
          HeadingSliderWidget(heading: 'X-Func Communication'),
          SizedBox(height: 16),
          HeadingSliderWidget(heading: 'X-Funct Accountability'),
          SizedBox(height: 16),
          HeadingSliderWidget(heading: 'Aligned Tech'),
          SizedBox(height: 16),
          HeadingSliderWidget(heading: 'Collaborative Processes'),
          HeadingSliderWidget(heading: 'Meeting Efficacy'),
          SizedBox(height: 16),
          HeadingSliderWidget(heading: 'Purpose Led Everything'),
          SizedBox(height: 16),
          HeadingSliderWidget(heading: 'Empowered Leadership')
        ],
      ),
    );
  }
}

class HeadingSliderWidget extends StatefulWidget {
  final String heading;
  final double value;
  const HeadingSliderWidget({super.key, required this.heading, this.value = 20});

  @override
  State<HeadingSliderWidget> createState() => _HeadingSliderWidgetState();
}

class _HeadingSliderWidgetState extends State<HeadingSliderWidget> {
  double sliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            widget.heading,
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
                setState(() {
                  sliderValue = value;
                });
              }),
        ),
      ],
    );
  }
}
