import 'package:flutter/material.dart';

import '../../../config/config.dart' show Strings;

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    this.controller,
    this.obscureText = false,
    this.onPressedSuffixIcon,
    this.validator,
    required this.labelText,
    this.style,
    this.focusNode,
    this.onEditingComplete,
    this.textInputAction,
    this.onFieldSubmitted,
    this.enabled,
  });

  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? onPressedSuffixIcon;
  final FormFieldValidator<String?>? validator;
  final String labelText;
  final TextStyle? style;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final void Function(String?)? onFieldSubmitted;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      style: style,
      decoration: InputDecoration(
        labelText: labelText,
        // hintText: 'Password',
        labelStyle: const TextStyle(
          color: Color(0xFF7F87A6),
          fontSize: 14,
          fontFamily: Strings.fontFamily,
          fontWeight: FontWeight.w600,
        ),
        errorStyle: const TextStyle(
          color: Color(0xFFC02D4F),
          fontSize: 12,
          fontFamily: Strings.fontFamily,
          fontWeight: FontWeight.w600,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_outlined : Icons.visibility_off,
          ),
          onPressed: onPressedSuffixIcon,
        ),
      ),
      validator: validator,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
