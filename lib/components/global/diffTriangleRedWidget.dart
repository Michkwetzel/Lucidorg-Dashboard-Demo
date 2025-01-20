import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class DiffTriangleRedWidget extends StatelessWidget {
  const DiffTriangleRedWidget({
    required this.size,
    super.key,
  });

  final Diffsize size;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = kH4PoppinsLight;
    double trianleSize = 15;

    switch (size) {
      case Diffsize.H1:
        textStyle = kH1Diff;
        trianleSize = 50;
      case Diffsize.H2:
        textStyle = kH5PoppinsLight;
        trianleSize = 20;
      case Diffsize.H3:
        textStyle = kH2Diff;
        trianleSize = 15;
      default:
        textStyle = kH6PoppinsLight;
        trianleSize = 15;
    }

    return Row(
      children: [
        Icon(Icons.arrow_drop_up, size: trianleSize, color: Colors.red), // or any color you prefer
        Text('~38%', style: textStyle),
      ],
    );
  }
}
