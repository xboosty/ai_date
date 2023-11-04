import 'package:flutter/material.dart';

import '../../../../config/config.dart' show Strings;

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    this.controller,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final void Function(String?)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF686E8C),
            width: 2.0,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF686E8C),
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(
        color: Color(0xFF686E8C),
        fontSize: 24,
        fontFamily: Strings.fontFamily,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
