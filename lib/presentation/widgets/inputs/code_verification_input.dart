import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../config/config.dart' show AppTheme;

class CodeVerificationInput extends StatelessWidget {
  const CodeVerificationInput({super.key, this.controller, this.validator});

  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        borderRadius: BorderRadius.circular(50),
        activeFillColor: Colors.white, // Color de relleno cuando tiene numero
        disabledColor: Colors.green, // No
        errorBorderColor: Colors.red.shade200,
        inactiveColor: AppTheme.disabledColor, // Colors of the lines
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        shape: PinCodeFieldShape.underline,
        // activeFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      // errorAnimationController: errorController,
      // controller: textEditingController,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        // print(value);
        // setState(() {
        //   currentText = value;
        // });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      validator: validator,
    );
  }
}
