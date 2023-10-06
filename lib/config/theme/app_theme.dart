import 'package:flutter/material.dart';

import '../config.dart' show Strings;

class AppTheme {
  final bool isDarkmode;

  // Colors
  static const Color firstColorBlur = Color(0xFF5005B0);
  static const Color secondColorBlur = Color(0xFFFF5A35);
  static const Color secondaryColor = Color(0xFF6D2EBC);
  static const Color disabledColor = Color(0xFFBDC0D6);

// Alignments Colors
  static const linearGradient = LinearGradient(
    begin: Alignment(0.94, 0.34),
    end: Alignment(-0.94, -0.34),
    colors: [firstColorBlur, secondColorBlur],
  );

  static const linearGradientReverse = LinearGradient(
    begin: Alignment(0.94, 0.34),
    end: Alignment(-0.94, -0.34),
    colors: [secondColorBlur, firstColorBlur],
  );

  static const linearGradientTopRightBottomLeft = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [secondColorBlur, firstColorBlur],
  );

  static final Shader linearGradientShader = const LinearGradient(
    colors: <Color>[firstColorBlur, secondColorBlur],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static final radialGradient = RadialGradient(
    center: Alignment.center,
    colors: [
      secondColorBlur,
      firstColorBlur,
      Colors.white.withOpacity(0.019999999552965164),
    ],
    radius: 0.8,
    focalRadius: 0.2,
  );

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        fontFamily: Strings.fontFamily,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF6C2EBC),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        // pageTransitionsTheme:  PageTransitionsTheme(
        //   builders: {
        //     TargetPlatform.android: CupertinoPageTransitionsBuilder().buildTransitions(route, context, animation, secondaryAnimation, child){
        //       return SlideInLeft(
        //         child: child,
        //       );
        //     },
        //     TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        //   },
        // ),
      );
}
