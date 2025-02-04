import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class ScoreBox extends StatefulWidget {
  final double height;
  final double width;
  final double score;
  final double textSize;
  final FontWeight fontWeight;

  const ScoreBox({super.key, required this.score, required this.width, required this.height, required this.textSize, required this.fontWeight});

  @override
  State<ScoreBox> createState() => _ScoreBoxState();
}

class _ScoreBoxState extends State<ScoreBox> {
  late double score = widget.score;

  BoxDecoration decoration = kGrayBox;

  @override
  void initState() {
    if (score < 40) {
      decoration = kRedBox;
    } else if (score < 50) {
      decoration = kYellowBox;
    } else if (score < 60) {
      decoration = kGrayBox;
    } else {
      decoration = kGreenBox;
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
          '${widget.score.toString()}%',
          style: TextStyle(fontSize: widget.textSize, fontFamily: 'Poppins', fontWeight: widget.fontWeight),
        ),
      ),
    );
  }
}
