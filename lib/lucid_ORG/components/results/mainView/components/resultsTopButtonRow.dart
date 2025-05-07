import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/components/resultsViewRadioButton.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class ResultsTopButtonRow extends StatelessWidget {
  const ResultsTopButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 32),
        ResultsViewRadioButton(buttonText: 'Overview', section: ResultSection.overview),
        //ResultsViewRadioButton(buttonText: 'Foundations', section: ResultSection.foundations),
        ResultsViewRadioButton(buttonText: 'Indicators', section: ResultSection.areaScore),
        ResultsViewRadioButton(buttonText: 'Differentiation', section: ResultSection.diffMatrix),
        ResultsViewRadioButton(buttonText: 'Change over time', section: ResultSection.diffOverTime),
      ],
    );
  }
}
