import 'package:flutter/material.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class CurrentActionAreaWidget extends StatelessWidget {
  const CurrentActionAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: kboxShadowNormal,
      child: Column(children: [
        const Text(
          'Current Action Area',
          style: kH2PoppinsRegular,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFDED6A3),
          ),
          child: const Text(
            'Meeting Efficacy',
            style: kH5PoppinsLight,
          ),
        ),
        SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Total Score', style: kH6PoppinsLight),
                Text('55.7%', style: kH6PoppinsLight),
              ],
            ),
            Column(
              children: [Text('Differentiation', style: kH6PoppinsLight), DiffTriangleRedWidget(size: Diffsize.H3)],
            )
          ],
        )
      ]),
    );
  }
}
