import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class DiffTriangleRedWidget extends StatelessWidget {
  const DiffTriangleRedWidget({
    this.noDecimals = false,
    this.allRed = false,
    this.allBlack = false,
    required this.value,
    required this.size,
    super.key,
  });
  final bool noDecimals;
  final Diffsize size;
  final double value;
  final bool allRed;
  final bool allBlack;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = kH4PoppinsLight;
    double trianleSize = 15;
    Color color = Colors.black;

    if (allRed) {
      color = Color(0xFFF03535);
    } else if (allBlack) {
      color = Color(0xFF3F3F3F);
    }

    switch (size) {
      case Diffsize.H1:
        textStyle = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 22, color: color);
        trianleSize = 28;
      case Diffsize.H2:
        textStyle = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 22, color: color);
        trianleSize = 24;
      case Diffsize.H3:
        textStyle = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 18, color: color);
        trianleSize = 22;
      case Diffsize.H4:
        textStyle = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 16, color: color);
        trianleSize = 20;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/trianlge.svg',
          width: trianleSize,
          height: trianleSize,
          colorFilter: ColorFilter.mode(allBlack ? color : Color(0xFFF03535), BlendMode.srcIn),
        ),
        noDecimals ? Text('~${value.toStringAsFixed(0)}%', style: textStyle) : Text('~$value%', style: textStyle),
      ],
    );
  }
}
