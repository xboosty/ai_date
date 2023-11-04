import 'package:ai_date/presentation/common/widgets/text/gradient_text.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart' show AppTheme, Strings;

class FilledColorizedOutlineButton extends StatelessWidget {
  const FilledColorizedOutlineButton({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.isTrailingIcon,
    this.onTap,
  });

  final double width;
  final double height;
  final String title;
  final bool isTrailingIcon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: AppTheme.linearGradient,
        ),
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GradientText(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
                gradient: AppTheme.linearGradient,
              ),
              isTrailingIcon ? const SizedBox(width: 5.0) : Container(),
              isTrailingIcon
                  ? const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
