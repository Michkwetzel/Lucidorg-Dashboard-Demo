import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/focus/main_view/action_step_1/stacked_pyramids.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class PyramidWidget extends StatelessWidget {
  const PyramidWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      width: 800,
      child: StackedPyramids(
        diffOrScore: DiffOrScore.diff,
        pyramids: [
          PyramidInfo(
            indicator: Indicator.leadership,
            title: 'Leadership',
            left: 296,
            top: 0,
            imagePath: 'assets/pyramide_blocks/leadership.png', // Or any other image
            onTap: () {
              print('Leadership pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.crossFuncComms,
            title: 'Communications',
            left: 208,
            top: 107,
            imagePath: 'assets/pyramide_blocks/communications.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('Owndership pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.crossFuncAcc,
            title: 'Accountability',
            left: 386,
            top: 107,
            imagePath: 'assets/pyramide_blocks/accountability.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.collabProcesses,
            title: 'Accountability',
            left: 119,
            top: 214,
            imagePath: 'assets/pyramide_blocks/processes.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.engagedCommunity,
            title: 'Accountability',
            left: 298,
            top: 214,
            imagePath: 'assets/pyramide_blocks/community.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.collabKPIs,
            title: 'Accountability',
            left: 476,
            top: 214,
            imagePath: 'assets/pyramide_blocks/kpi.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.alignedTech,
            title: 'Accountability',
            left: 30,
            top: 321.5,
            imagePath: 'assets/pyramide_blocks/technology.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.meetingEfficacy,
            title: 'Accountability',
            left: 209,
            top: 321.5,
            imagePath: 'assets/pyramide_blocks/meeting.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.growthAlign,
            title: 'Accountability',
            left: 387,
            top: 321.5,
            imagePath: 'assets/pyramide_blocks/growth align.png',
            onTap: () {
              // Do something when this pyramid is tapped
              print('bleh pyramid tapped');
            },
          ),
          PyramidInfo(
            indicator: Indicator.orgAlign,
            title: 'Accountability',
            left: 566,
            top: 321.5,
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
