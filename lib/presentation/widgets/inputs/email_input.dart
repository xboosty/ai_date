import 'package:flutter/material.dart';

import '../../../config/config.dart' show Strings;

class EmailInput extends StatelessWidget {
  const EmailInput({super.key, this.controller, this.validator});

  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
    );
  }
}
