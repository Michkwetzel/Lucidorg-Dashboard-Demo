import 'package:flutter/widgets.dart';
import 'package:platform_front/core_config/constants.dart';

class ResultsBodyOrg extends StatelessWidget {
  const ResultsBodyOrg({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          SizedBox(
            width: 1060,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Results Lucid HR",
                  style: kH1TextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
