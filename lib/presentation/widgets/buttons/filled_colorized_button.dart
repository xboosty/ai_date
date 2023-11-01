import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme;

class FilledColorizedButton extends StatelessWidget {
  const FilledColorizedButton({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.isTrailingIcon,
    this.onTap,
    required this.icon,
    this.gradient = AppTheme.linearGradient,
  });

  final double width;
  final double height;
  final String title;
  final bool isTrailingIcon;
  final Icon icon;
  final GestureTapCallback? onTap;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: ShapeDecoration(
          gradient: gradient,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                height: 0.09,
              ),
            ),
            isTrailingIcon ? const SizedBox(width: 5.0) : Container(),
            isTrailingIcon ? icon : Container()
          ],
        ),
      ),
    );
  }
}
