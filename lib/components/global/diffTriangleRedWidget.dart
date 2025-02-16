import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class DiffTriangleRedWidget extends StatelessWidget {
  const DiffTriangleRedWidget({
    this.noDecimals = false,
    required this.value,
    required this.size,
    super.key,
    this.allRed = false,
  });
  final bool noDecimals;
  final Diffsize size;
  final double value;
  final bool allRed;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = kH4PoppinsLight;
    double trianleSize = 15;
    Color textColor = Colors.black;

    if (allRed) {
      textColor = Color(0xFFF03535);
    }

    switch (size) {
      case Diffsize.H1:
        textStyle = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 22, color: textColor);
        trianleSize = 28;
      case Diffsize.H2:
        textStyle = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 22, color: textColor);
        trianleSize = 24;
      case Diffsize.H3:
        textStyle = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 18, color: textColor);
        trianleSize = 22;
      case Diffsize.H4:
        textStyle = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 16, color: textColor);
        trianleSize = 20;

      default:
        textStyle = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 14, color: textColor);
        trianleSize = 15;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/trianlge.svg',
          width: trianleSize,
          height: trianleSize,
          colorFilter: const ColorFilter.mode(Color(0xFFF03535), BlendMode.srcIn),
        ),
        noDecimals ? Text('~${value.toStringAsFixed(0)}%', style: textStyle) :
        Text('~$value%', style: textStyle),
      ],
    );
  }
}
