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
        ResultsViewRadioButton(buttonText: 'Area Scores', section: ResultSection.areaScore),
        ResultsViewRadioButton(buttonText: 'Differentiation Matrix', section: ResultSection.diffMatrix),
        ResultsViewRadioButton(buttonText: 'Sub-Area View', section: ResultSection.subAreaView),
      ],
    );
  }
}
