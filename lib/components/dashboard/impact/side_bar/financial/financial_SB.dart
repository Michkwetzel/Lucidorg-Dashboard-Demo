import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class FinancialSB extends StatefulWidget {
  const FinancialSB({super.key});

  @override
  State<FinancialSB> createState() => _FinancialSBState();
}

class _FinancialSBState extends State<FinancialSB> {
  @override
  double sliderValue = 2;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25).copyWith(top: 40),
      child: Column(
        spacing: 32,
        children: [
          Text(
            'Projected Org Impact',
            style: kH2PoppinsLight,
          ),
          FinancialSBRow(heading: 'Increased Profit', value: 15),
          FinancialSBRow(heading: 'Decreased Cost', value: 34),
          FinancialSBRow(heading: 'increase Margin', value: 43),
          FinancialSBRow(heading: 'Increased NPS', value: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Text(
                      'Time Frame:   ',
                      style: kH4PoppinsLight,
                    ),
                    Text(
                      '$sliderValue years',
                      style: kH4PoppinsLight,
                    )
                  ],
                ),
              ),
              Slider(
                  activeColor: Color(0xFFB9D08F),
                  label: sliderValue.toString(),
                  divisions: 3,
                  value: sliderValue,
                  min: 0,
                  max: 3,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }
}

class FinancialSBRow extends StatelessWidget {
  final String heading;
  final int value;
  const FinancialSBRow({super.key, required this.heading, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          heading,
          style: kH3PoppinsLight,
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: 80,
          height: 60,
          decoration: kGrayBox,
          child: Center(child: Text('$value%', style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Poppins', fontWeight: FontWeight.w400))),
        ),
      ],
    );
  }
}
