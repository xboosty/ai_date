import 'package:flutter/material.dart';

import '../../../../config/config.dart' show Strings;

class ConfigurationInputField extends StatelessWidget {
  const ConfigurationInputField({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.fontSize,
    this.colorLabel,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
    this.errorMaxLines,
    this.isEnabledField = true,
  });

  final String labelText;
  final TextInputType? keyboardType;
  final double? fontSize;
  final Color? colorLabel;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final int? errorMaxLines;
  final bool isEnabledField;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: keyboardType,
      enabled: isEnabledField,
      textCapitalization: TextCapitalization.none,
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
        errorMaxLines: errorMaxLines,
      ),
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}
