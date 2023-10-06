import 'package:flutter/material.dart';

import '../../../config/config.dart' show Strings;

class OutlineText extends StatelessWidget {
  const OutlineText({
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
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        foreground: Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
        fontFamily: Strings.fontFamily,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
