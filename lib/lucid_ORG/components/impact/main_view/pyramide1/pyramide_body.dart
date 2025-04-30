import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/lucid_ORG/components/impact/main_view/pyramide1/stacked_pyramids.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class PyramideBody extends StatelessWidget {
  const PyramideBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18),
        CustomDivider(),
        PyramidWidget(),
      ],
    );
  }
}

class PyramidWidget extends StatelessWidget {
  const PyramidWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: StackedPyramids(
        diffOrScore: DiffOrScore.diff,
        pyramids: [
          PyramidInfo(
            indicator: Indicator.leadership,
            title: 'Leadership',
            left: 500,
            top: 0,
            imagePath: 'assets/pyramide_blocks/leadership.png', // Or any other image
            onTap: () {
              print('Leadership pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.crossFuncComms,
            title: 'Communications',
            left: 402,
            top: 119,
            imagePath: 'assets/pyramide_blocks/communications.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('Owndership pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.crossFuncAcc,
            title: 'Accountability',
            left: 600,
            top: 118.5,
            imagePath: 'assets/pyramide_blocks/accountability.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.collabProcesses,
            title: 'Accountability',
            left: 303,
            top: 238,
            imagePath: 'assets/pyramide_blocks/processes.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.engagedCommunity,
            title: 'Accountability',
            left: 502,
            top: 237.5,
            imagePath: 'assets/pyramide_blocks/community.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.collabKPIs,
            title: 'Accountability',
            left: 701,
            top: 237.5,
            imagePath: 'assets/pyramide_blocks/kpi.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.alignedTech,
            title: 'Accountability',
            left: 204,
            top: 357.5,
            imagePath: 'assets/pyramide_blocks/technology.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.meetingEfficacy,
            title: 'Accountability',
            left: 403,
            top: 357,
            imagePath: 'assets/pyramide_blocks/meeting.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.growthAlign,
            title: 'Accountability',
            left: 601.5,
            top: 357,
            imagePath: 'assets/pyramide_blocks/growth align.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.orgAlign,
            title: 'Accountability',
            left: 800.5,
            top: 357,
            imagePath: 'assets/pyramide_blocks/org align.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
        ],
      ),
    );
  }
}
