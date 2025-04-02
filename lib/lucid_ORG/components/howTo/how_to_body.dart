import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platform_front/core_config/constants.dart';

class HowToBody extends StatelessWidget {
  const HowToBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Text(
          "How To",
          style: kH1TextStyle,
        ),
        SizedBox(height: 100,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 32,
          children: [
            Text(
              "Creating an Assessment",
              style: kH2TextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                )
              ],
            ),
            Row(
              spacing: 100,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  spacing: 32,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Viewing Results",
                      style: kH2TextStyle,
                    ),
                    Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: 32,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Viewing Impact",
                      style: kH2TextStyle,
                    ),
                    Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
