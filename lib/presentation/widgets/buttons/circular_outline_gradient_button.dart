import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme;

class CircularOutlineGradientButton extends StatelessWidget {
  const CircularOutlineGradientButton({
    super.key,
    required this.width,
    required this.height,
    this.onTap,
    this.child,
  });

  final double width;
  final double height;
  final GestureTapCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 1.5),
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          shape: BoxShape.circle,
          gradient: AppTheme.linearGradient,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
