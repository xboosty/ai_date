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
  bool obscureTextCurrentPassword = true;
  bool obscureTextNewPassword = true;
  bool obscureTextRepeatPassword = true;

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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Column(
          children: [
            PasswordInput(
              labelText: 'Current password',
              obscureText: obscureTextCurrentPassword,
              style: const TextStyle(
                color: Color(0xFF261638),
                fontSize: 14,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            PasswordInput(
              labelText: 'New password',
              obscureText: obscureTextNewPassword,
              style: const TextStyle(
                color: Color(0xFF261638),
                fontSize: 14,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            PasswordInput(
              labelText: 'Repeat password',
              obscureText: obscureTextRepeatPassword,
              style: const TextStyle(
                color: Color(0xFF261638),
                fontSize: 14,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            FilledButton(
              onPressed: null,
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
    );
  }
}
