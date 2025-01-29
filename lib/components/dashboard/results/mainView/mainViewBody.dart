import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/secondaryButton.dart';
import 'package:platform_front/components/dashboard/results/mainView/resultsViewRadioButton.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class MainViewBody extends ConsumerWidget {
  const MainViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResultSection selectedSection = ref.watch(resultsSelectedSectionProvider);

    Widget _returnMainViewWidget() {
      switch (selectedSection) {
        case ResultSection.overview:
          return OverviewMainView();
        default:
          return Placeholder();
      }
    }

    return Container(
      width: 800,
      padding: EdgeInsets.all(32),
      margin: EdgeInsets.only(left: 5, bottom: 5),
      decoration: kboxShadowNormal,
      child: Column(
        children: [
          ResultsTopButtonRow(),
          SizedBox(height: 16,),
          _returnMainViewWidget(),
        ],
      ),
    );
  }
}

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

class OverviewMainView extends StatelessWidget {
  const OverviewMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Company Trajectory', style: kH3PoppinsRegular),
        SizedBox(
          height: 400,
          width: 500,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Overview:',
            style: kH3PoppinsLight,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Your overall efficiency benchmark assessment is 61%, which is slightly above average for companies at your stage of growth, and just 9 points below the 70% threshold for smooth scaling!\n\nYour overall differentiation is at 15% which is average for companies at your current stage of growth\n\nFocussing on areas of high differentiation first is imperative and provides the most impact across the organization',
            style: kH5PoppinsRegular,
          ),
        )
      ],
    );
  }
}
