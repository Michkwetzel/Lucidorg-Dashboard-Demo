import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class FinancialSB extends ConsumerStatefulWidget {
  const FinancialSB({super.key});

  @override
  ConsumerState<FinancialSB> createState() => _FinancialSBState();
}

class _FinancialSBState extends ConsumerState<FinancialSB> {
  late double sliderValue;

  @override
  void initState() {
    super.initState();
    sliderValue = ref.read(financeModelProvider.notifier).getCurrentTimeFrame();
  }

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
          FinancialSBRow(heading: 'Increased Profit', value: ref.watch(financeModelProvider).profitIncrease * 100),
          FinancialSBRow(heading: 'Decreased Cost', value: ref.watch(financeModelProvider).costDecrease * 100),
          FinancialSBRow(heading: 'increase Margin', value: ref.watch(financeModelProvider).marginIncrease * 100),
          FinancialSBRow(heading: 'Productivity Increase', value: ref.watch(financeModelProvider).employeProductivityIncrease * 100),
          FinancialSBRow(heading: 'Turnover Decrease', value: ref.watch(financeModelProvider).turnoverDecrease * 100),
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
                    ref.read(financeModelProvider.notifier).timeFrameChange(value);
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
  final double value;
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
          width: 100,
          height: 60,
          decoration: kGrayBox,
          child: Center(child: Text('${value.toStringAsFixed(1)}%', style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Poppins', fontWeight: FontWeight.w400))),
        ),
      ],
    );
  }
}
