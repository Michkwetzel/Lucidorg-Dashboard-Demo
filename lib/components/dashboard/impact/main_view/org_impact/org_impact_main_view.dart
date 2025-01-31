import 'package:flutter/material.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';

class OrgImpactMainView extends StatelessWidget {
  const OrgImpactMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Impact Chart',
            style: kH3PoppinsMedium,
          ),
          SizedBox(height: 6),
          GrayDivider(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
