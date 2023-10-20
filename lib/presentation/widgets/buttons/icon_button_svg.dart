import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconButtonSvg extends StatelessWidget {
  const IconButtonSvg({
    super.key,
    required this.urlSvg,
    required this.semanticsLabel,
    required this.heroTag,
    this.backgroundColor,
    this.onPressed,
  });

  final String urlSvg;
  final String semanticsLabel;
  final String heroTag;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      elevation: 0.0,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: SvgPicture.asset(
        urlSvg,
        semanticsLabel: semanticsLabel,
      ),
    );
  }
}
