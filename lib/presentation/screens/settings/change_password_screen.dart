import 'package:flutter/material.dart';

import '../../../config/config.dart' show Strings;
import '../../widgets/widgets.dart' show PasswordInput;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String routeName = '/change_password';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscureTextCurrentPassword = true;
  bool obscureTextNewPassword = true;
  bool obscureTextRepeatPassword = true;

  final TextEditingController currentCtrl = TextEditingController();
  final TextEditingController newCtrl = TextEditingController();
  final TextEditingController repeatCtrl = TextEditingController();

  String? _validateCurrentPassword(String value) {
    // Define your password validation logic here.
    if (value.isEmpty) {
      return 'Password is required';
    }
    // Check if the password length is at least 8 characters.
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Use regular expressions to enforce additional rules.
    if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$')
        .hasMatch(value)) {
      return 'Please insert a valid password';
    }
    return null; // Return null if the input is valid.
  }

  String? _validateNewPassword(String value) {
    // Define your password validation logic here.
    if (value.isEmpty) {
      return 'Password is required';
    }
    // Check if the password length is at least 8 characters.
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Use regular expressions to enforce additional rules.
    if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$')
        .hasMatch(value)) {
      return 'Please insert a valid password';
    }
    return null; // Return null if the input is valid.
  }

  String? _validateRepeatPassword(String value) {
    // Define your password validation logic here.
    if (value.isEmpty) {
      return 'Password is required';
    }
    // Check if the password length is at least 8 characters.
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Check if the new password and repeat password it's the same.
    if (value != newCtrl.text) {
      return 'The new password and repeat password \nfields must be the same';
    }
    // Use regular expressions to enforce additional rules.
    if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$')
        .hasMatch(value)) {
      return 'Please insert a valid password';
    }
    return null; // Return null if the input is valid.
  }

  // For Register User
  void _submitChangePassword() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _username variable for further processing.
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Change password',
          style: TextStyle(
            color: Color(0xFF261638),
            fontSize: 20,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Column(
                children: [
                  PasswordInput(
                    controller: currentCtrl,
                    labelText: 'Current password',
                    obscureText: obscureTextCurrentPassword,
                    style: const TextStyle(
                      color: Color(0xFF261638),
                      fontSize: 14,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressedSuffixIcon: () {
                      setState(() {
                        obscureTextCurrentPassword =
                            !obscureTextCurrentPassword;
                      });
                    },
                    validator: (value) => _validateCurrentPassword(value ?? ''),
                  ),
                  PasswordInput(
                    controller: newCtrl,
                    labelText: 'New password',
                    obscureText: obscureTextNewPassword,
                    style: const TextStyle(
                      color: Color(0xFF261638),
                      fontSize: 14,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressedSuffixIcon: () {
                      setState(() {
                        obscureTextNewPassword = !obscureTextNewPassword;
                      });
                    },
                    validator: (value) => _validateNewPassword(value ?? ''),
                  ),
                  PasswordInput(
                    controller: repeatCtrl,
                    labelText: 'Repeat password',
                    obscureText: obscureTextRepeatPassword,
                    style: const TextStyle(
                      color: Color(0xFF261638),
                      fontSize: 14,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressedSuffixIcon: () {
                      setState(() {
                        obscureTextRepeatPassword = !obscureTextRepeatPassword;
                      });
                    },
                    validator: (value) => _validateRepeatPassword(value ?? ''),
                  ),
                  // SizedBox(height: size.height * 0.05),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Your password should be at least 8 characters long and include a combination of uppercase letters, lowercase letters, numbers, and special characters for added security',
                      style: TextStyle(
                        color: Color(0xFF9CA4BF),
                        fontSize: 12,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  FilledButton(
                    onPressed: () => _submitChangePassword(),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      disabledBackgroundColor: const Color(0xFF7F87A6),
                    ),
                    child: const Text(
                      'SET NEW PASSWORD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
