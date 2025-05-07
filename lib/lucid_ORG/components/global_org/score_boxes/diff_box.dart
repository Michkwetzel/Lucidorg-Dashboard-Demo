import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';

class DiffBox extends StatefulWidget {
  final double height;
  final double width;
  final double diff;
  final double textSize;
  final FontWeight fontWeight;

  const DiffBox({super.key, required this.diff, required this.width, required this.height, required this.textSize, required this.fontWeight});

  @override
  State<DiffBox> createState() => _DiffBoxState();
}

class _DiffBoxState extends State<DiffBox> {
  late double diff = widget.diff;

  BoxDecoration decoration = kGrayBox;

  @override
  void initState() {
    if (diff < 5) {
      decoration = kGreenBox;
    } else if (diff < 10) {
      decoration = kGrayBox;
    } else if (diff < 20) {
      decoration = kYellowBox;
    } else {
      decoration = kRedBox;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: decoration,
      child: Center(
        child: Text(
          '~${widget.diff.toString()}%',
          style: TextStyle(fontSize: widget.textSize, fontFamily: 'Poppins', fontWeight: widget.fontWeight),
        ),
      ),
    );
  }
}
