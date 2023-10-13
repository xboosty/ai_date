import 'package:flutter/material.dart';

import '../../../config/config.dart' show Strings;
import '../../widgets/widgets.dart' show FilledColorizedButton;
import 'sign_in_screen.dart';

class SuccessChangePasswordScreen extends StatelessWidget {
  const SuccessChangePasswordScreen({super.key});

  static const String routeName = '/success_change_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCC1EA),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFFCCC1EA),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/imgs/success_change_password.png'),
            ),
            const Text(
              'Password successfully changed for your account!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6C2EBC),
                fontSize: 28,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            FilledColorizedButton(
              width: 165,
              height: 50,
              title: 'LET\'S START',
              isTrailingIcon: true,
              onTap: () =>
                  Navigator.of(context).pushNamed(SignInScreen.routeName),
              icon: const Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
