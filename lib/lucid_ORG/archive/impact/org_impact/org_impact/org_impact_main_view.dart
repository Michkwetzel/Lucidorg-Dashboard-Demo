import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class OrgImpactMainView extends StatelessWidget {
  const OrgImpactMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text('Impact Chart', style: kH3PoppinsMedium),
          SizedBox(height: 6),
          CustomDivider(),
          SizedBox(height: 32),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Align(alignment: AlignmentDirectional.center, child: ImpactChart()),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 90),
            child: ImpactGraphKey())
        ],
      ),
    );
  }
}

class ImpactGraphKey extends StatelessWidget {
  const ImpactGraphKey({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 32,
      children: [
        Row(
          children: [
            Text(
              'KEY | ',
              style: TextStyle(color: Colors.black, fontFamily: 'Open Sans', fontWeight: FontWeight.w600, fontSize: 14),
            ),
            Text('ORG IMPACT MAGNITUDE'),
          ],
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 0.8,
            ),
          ),
          child: Center(
            child: Text(
              'Med',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 18, color: Color(0xFF24527E)),
            ),
          ),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 0.8,
            ),
          ),
          child: Center(
            child: Text(
              'High',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 20, color: Color(0xFF24527E)),
            ),
          ),
        ),
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 0.8,
            ),
          ),
          child: Center(
            child: Text(
              'Extreme',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 20, color: Color(0xFF24527E)),
            ),
          ),
        ),
      ],
    );
  }
}

class ImpactChart extends ConsumerWidget {
  const ImpactChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    List<Indicator> indicatorsToShow = displayData.returnImpactChartIndicators();
    List<ImpactCircle> circlesToShow = [];

    for (Indicator indicator in indicatorsToShow) {
      double diff = displayData.diffScores[indicator]!;
      double score = displayData.companyBenchmarks[indicator]!;
      circlesToShow.add(ImpactCircle(indicator: indicator, score: score, diff: diff));
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        ImpactGraphAxis(),
        ...circlesToShow,
      ],
    );
  }
}

class ImpactGraphAxis extends StatelessWidget {
  const ImpactGraphAxis({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.grey,
          width: 1,
          height: 700,
        ),
        Container(
          color: Colors.grey,
          width: 800,
          height: 1,
        ),
        Positioned(
          left: -6,
          child: ImpactGraphLabelArrowLeft(text: 'EASIER TO IMPLEMENT'),
        ),
        Positioned(
          right: -6,
          child: ImpactGraphLabelArrowRight(text: 'HARDER TO IMPLEMENT'),
        ),
        Positioned(
          top: -6,
          child: ImpactGraphLabelArrowUp(text: 'MORE TIME TO IMPACT'),
        ),
        Positioned(
          bottom: -6,
          child: ImpactGraphLabelArrowDown(text: 'LESS TIME TO IMPACT'),
        ),
      ],
    );
  }
}

class ImpactGraphLabelArrowDown extends StatelessWidget {
  final String text;
  const ImpactGraphLabelArrowDown({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        RotatedBox(
          quarterTurns: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: Color(0xFFA2B185), borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontFamily: 'Open Sans', fontWeight: FontWeight.w300, fontSize: 14),
            ),
          ),
        ),
        RotatedBox(quarterTurns: 1, child: Icon(Icons.play_arrow)),
      ],
    );
  }
}

class ImpactGraphLabelArrowUp extends StatelessWidget {
  final String text;
  const ImpactGraphLabelArrowUp({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        RotatedBox(quarterTurns: 3, child: Icon(Icons.play_arrow)),
        RotatedBox(
          quarterTurns: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: Color(0xFFA2B185), borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontFamily: 'Open Sans', fontWeight: FontWeight.w300, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}

class ImpactGraphLabelArrowRight extends StatelessWidget {
  final String text;
  const ImpactGraphLabelArrowRight({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: Color(0xFFA2B185), borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontFamily: 'Open Sans', fontWeight: FontWeight.w300, fontSize: 14),
          ),
        ),
        RotatedBox(quarterTurns: 0, child: Icon(Icons.play_arrow)),
      ],
    );
  }
}

class ImpactGraphLabelArrowLeft extends StatelessWidget {
  final String text;
  const ImpactGraphLabelArrowLeft({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        RotatedBox(quarterTurns: 2, child: Icon(Icons.play_arrow)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: Color(0xFFA2B185), borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontFamily: 'Open Sans', fontWeight: FontWeight.w300, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class ImpactCircle extends ConsumerWidget {
  final double score;
  final double diff;
  final Indicator indicator;

  const ImpactCircle({super.key, required this.indicator, required this.score, required this.diff});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Instead of using right/bottom, just use top/left for positioning
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    Color returnColor() {
      double diff = displayData.diffScores[indicator]!;
      double score = displayData.companyBenchmarks[indicator]!;

      if (score < 40 || diff > 25) {
        return Color(0xFFF19C79);
      } else if (score < 50 || diff > 15) {
        return Color(0xFFF2C479);
      } else if (score < 60 || diff > 5) {
        return Color(0xFFEBEBEB);
      } else {
        return Color(0xFFB9D08F);
      }
    }

    double top = 0;
    double left = 0;
    ImpactSize size = ImpactSize.small;
    String number = '1';

    switch (indicator) {
      case Indicator.orgAlign:
        size = ImpactSize.large;
        left = 40;
        top = 470;
        number = "1";
      case Indicator.growthAlign:
        size = ImpactSize.small;
        left = 30;
        top = 610;
        number = "2";
      case Indicator.purposeDriven:
        size = ImpactSize.large;
        left = 205;
        top = 450;
        number = "10";
      case Indicator.crossFuncComms:
        size = ImpactSize.medium;
        left = 295;
        top = 355;
        number = "5";
      case Indicator.meetingEfficacy:
        size = ImpactSize.small;
        left = 200;
        top = 360;
        number = "9";
      case Indicator.collabProcesses:
        size = ImpactSize.large;
        left = 250;
        top = 200;
        number = "8";
      case Indicator.alignedTech:
        size = ImpactSize.medium;
        left = 415;
        top = 240;
        number = "7";
      case Indicator.engagedCommunity:
        size = ImpactSize.large;
        left = 430;
        top = 95;
        number = "4";
      case Indicator.crossFuncAcc:
        size = ImpactSize.large;
        left = 560;
        top = 195;
        number = "6";
      case Indicator.empoweredLeadership:
        size = ImpactSize.large;
        left = 640;
        top = 0;
        number = "11";
      case Indicator.collabKPIs:
        size = ImpactSize.medium;
        left = 415;
        top = 365;
        number = "3";
      default:
        size = ImpactSize.small;
        left = 30;
        top = 500;
        number = "1";
    }

    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: size == ImpactSize.large
            ? 140
            : size == ImpactSize.medium
                ? 100
                : 60,
        height: size == ImpactSize.large
            ? 140
            : size == ImpactSize.medium
                ? 100
                : 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: returnColor(),
          border: Border.all(
            color: Colors.grey,
            width: 0.8,
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 27, color: Color(0xFF24527E)),
          ),
        ),
      ),
    );
  }
}
