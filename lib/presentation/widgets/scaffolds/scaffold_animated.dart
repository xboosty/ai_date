import 'package:flutter/material.dart';

import '../widgets.dart' show OutlineAnimatedText;

class ScaffoldAnimated extends StatelessWidget {
  const ScaffoldAnimated({
    super.key,
    required this.size,
    required this.child,
    required this.decoration,
  });

  final Size size;
  final Widget child;
  final Decoration decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: decoration,
      // const BoxDecoration(
      //   gradient: AppTheme.linearGradientTopRightBottomLeft,
      // ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Positioned(
              top: -28,
              child: OutlineAnimatedText(
                title: 'Smarter Connections',
                color: Colors.white,
                fontSize: 80,
              ),
            ),
            const Positioned(
              bottom: -28,
              child: OutlineAnimatedText(
                title: 'Better Dates',
                color: Colors.white,
                fontSize: 80,
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
