import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/mainView/components/resultsViewRadioButton.dart';
import 'package:platform_front/config/enums.dart';

class ResultsTopButtonRow extends StatelessWidget {
  const ResultsTopButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ResultsViewRadioButton(buttonText: 'Overview', section: ResultSection.overview),
        ResultsViewRadioButton(buttonText: 'Differentiation', section: ResultSection.diffMatrix),
        ResultsViewRadioButton(buttonText: 'Indicators', section: ResultSection.areaScore),
        ResultsViewRadioButton(buttonText: 'Foundations', section: ResultSection.foundations),
      ],
    );
  }
}
