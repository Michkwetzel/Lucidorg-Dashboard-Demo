import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/secondaryButton.dart';
import 'package:platform_front/components/dashboard/impact/main_view/org_impact/org_impact_main_view.dart';
import 'package:platform_front/components/dashboard/impact/main_view/score_over_time/score_over_time_MV.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class ImpactMainView extends ConsumerWidget {
  const ImpactMainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImpactSection selectedSection = ref.watch(impactSelectedSectionProvider);

    Widget returnMainViewWidget() {
      switch (selectedSection) {
        case ImpactSection.orgImpact:
          return OrgImpactMainView();

        case ImpactSection.financial:
          return Placeholder();

        case ImpactSection.diffOverTime:
          return Placeholder();

        case ImpactSection.scoreOverTime:
          return ScoreOverTimeMV();
      }
    }

    return Container(
      width: 800,
      height: selectedSection == ImpactSection.scoreOverTime ? null : 850,
      padding: EdgeInsets.all(32),
      margin: EdgeInsets.only(left: 5, bottom: 5, right: 5),
      decoration: kboxShadowNormal,
      child: Column(
        children: [
          ImpactTopButtonRow(),
          SizedBox(
            height: 32,
          ),
          returnMainViewWidget(),
        ],
      ),
    );
  }
}

class ImpactTopButtonRow extends StatelessWidget {
  const ImpactTopButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImpactViewRadioButton(buttonText: 'Org Impact', section: ImpactSection.orgImpact),
        ImpactViewRadioButton(buttonText: 'Financial', section: ImpactSection.financial),
        ImpactViewRadioButton(buttonText: 'Score over time', section: ImpactSection.scoreOverTime),
        ImpactViewRadioButton(buttonText: 'Diff over time', section: ImpactSection.diffOverTime),
      ],
    );
  }
}

class ImpactViewRadioButton extends ConsumerWidget {
  final String buttonText;
  final ImpactSection section;

  const ImpactViewRadioButton({super.key, required this.buttonText, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImpactSection selectedSection = ref.watch(impactSelectedSectionProvider);

    if (selectedSection == section) {
      return CallToActionButton(onPressed: () {}, buttonText: buttonText);
    } else {
      return Secondarybutton(onPressed: () => ref.read(impactSelectedSectionProvider.notifier).setDisplay(section), buttonText: buttonText);
    }
  }
}
