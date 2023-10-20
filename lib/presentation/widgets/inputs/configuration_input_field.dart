import 'package:flutter/material.dart';

import '../../../config/config.dart' show Strings;

class ConfigurationInputField extends StatelessWidget {
  const ConfigurationInputField({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.fontSize,
    this.colorLabel,
    this.suffixIcon,
    this.controller,
  });

  final String labelText;
  final TextInputType? keyboardType;
  final double? fontSize;
  final Color? colorLabel;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      style: const TextStyle(
        color: Color(0xFF261638),
        fontSize: 14,
        fontFamily: Strings.fontFamily,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: colorLabel,
          fontSize: fontSize,
          fontFamily: Strings.fontFamily,
          fontWeight: FontWeight.w600,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
