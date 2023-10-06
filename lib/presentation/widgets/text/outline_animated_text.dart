import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../../config/config.dart' show Strings;

class OutlineAnimatedText extends StatelessWidget {
  const OutlineAnimatedText({
    super.key,
    required this.title,
    required this.color,
    required this.fontSize,
  });

  final String title;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height * 0.20,
      child: Marquee(
        text: title,
        blankSpace: 30,
        style: TextStyle(
          fontSize: fontSize,
          foreground: Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0,
          fontFamily: Strings.fontFamily,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
