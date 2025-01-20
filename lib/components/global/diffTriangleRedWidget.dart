import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class DiffTriangleRedWidget extends StatelessWidget {
  const DiffTriangleRedWidget({
    required this.value,
    required this.size,
    super.key,
  });

  final Diffsize size;
  final dynamic value;

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
        trianleSize = 40;
      case Diffsize.H3:
        textStyle = kH2Diff;
        trianleSize = 30;
      default:
        textStyle = kH6PoppinsLight;
        trianleSize = 25;
    }

    return Row(
      children: [
        Icon(Icons.arrow_drop_up, size: trianleSize, color: Colors.red), // or any color you prefer
        Text(value, style: textStyle),
      ],
    );
  }
}
