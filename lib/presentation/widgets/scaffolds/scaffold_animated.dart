import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme;
import '../widgets.dart' show OutlineAnimatedText;

class ScaffoldAnimated extends StatelessWidget {
  const ScaffoldAnimated({
    super.key,
    required this.size,
    required this.child,
  });

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: const BoxDecoration(
        gradient: AppTheme.linearGradientTopRightBottomLeft,
      ),
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
    );
  }
}
