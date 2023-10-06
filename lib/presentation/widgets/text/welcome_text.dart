import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme, Strings;

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
    this.fontSize,
  });

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: Strings.fontFamily,
        fontWeight: FontWeight.w800,
        foreground: Paint()
          ..shader = AppTheme.linearGradientShader
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      ),
    );
  }
}
