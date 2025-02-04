import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/diif_matrix_sb/area_diff_row.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class BestWorstAllignedWidget extends StatelessWidget {
  final Alligned type;
  const BestWorstAllignedWidget({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    String heading = 'Best Aligned';
    if (type == Alligned.worst) {
      heading = 'Worst aligned';
    }

    return Column(
      spacing: 16,
      children: [
        Text(heading, style: kH3PoppinsRegular),
        AreaDiffRow(heading: 'Meeting Efficacy', diff: 20.5),
        AreaDiffRow(heading: 'X-Functional Comms', diff: 13.5),
        AreaDiffRow(heading: 'Collaborative KPI\'s', diff: 2),
      ],
    );
  }
}
