import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../../widgets/widgets.dart'
    show
        CodeVerificationInput,
        EmailInput,
        FilledColorizedOutlineButton,
        PasswordInput,
        ScaffoldAnimated;
import '../screens.dart' show SuccessChangePasswordScreen;

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  static const String routeName = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: ScaffoldAnimated(
          size: size,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: size.width * 0.93,
                height: size.height * 0.83,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: size.width,
                        height: size.height * 0.25,
                        decoration: const BoxDecoration(
                          gradient: AppTheme.linearGradientTopRightBottomLeft,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_downward,
                                color: Colors.white),
                            SizedBox(height: size.height * 0.02),
                            const Text(
                              'Forgot your password?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontFamily: Strings.fontFamily,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                              vertical: size.height / 25),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: _WizardScreen(),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WizardScreen extends StatefulWidget {
  @override
  _WizardScreenState createState() => _WizardScreenState();
}

class _WizardScreenState extends State<_WizardScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        // Stepper horizontal
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3, // Reemplaza este número con la cantidad de pasos que desees
            (index) {
              return Row(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Colors.purple
                          : AppTheme.disabledColor,
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (index <
                      2) // Agregar línea entre los elementos excepto el último
                    Container(
                      width: size.width * 0.08,
                      height: 1.0,
                      color: Colors.grey,
                    ),
                ],
              );
            },
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // Aquí puedes colocar el contenido de cada paso
              StepPage(
                icon: const Icon(
                  Icons.key,
                  color: Colors.purple,
                  size: 32,
                ),
                content: const EmailInput(),
                button: FilledColorizedOutlineButton(
                  width: 150,
                  height: 50,
                  title: 'NEXT',
                  isTrailingIcon: false,
                  onTap: () {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                ),
                isHelperText: true,
                helperText:
                    'Enter the email address associated with your account to reset your password.',
              ),
              StepPage(
                icon: const Icon(
                  Icons.mark_as_unread,
                  color: Colors.purple,
                  size: 32,
                ),
                content: const CodeVerificationInput(),
                button: FilledColorizedOutlineButton(
                  width: 150,
                  height: 50,
                  title: 'VERIFY',
                  isTrailingIcon: false,
                  onTap: () {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                ),
                isHelperText: true,
                helperText:
                    'We\'ve dispatched a verification code to your email address. Please enter it here to authenticate and secure your account.',
              ),
              StepPage(
                icon: const Icon(
                  Icons.shield_outlined,
                  color: Colors.purple,
                  size: 32,
                ),
                content: SingleChildScrollView(
                  child: const Column(
                    children: [
                      PasswordInput(
                        labelText: 'New Password',
                      ),
                      PasswordInput(
                        labelText: 'Confirm Password',
                      ),
                    ],
                  ),
                ),
                button: FilledColorizedOutlineButton(
                  width: 187,
                  height: 50,
                  title: 'RESET PASSWORD',
                  isTrailingIcon: false,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SuccessChangePasswordScreen.routeName);
                  },
                ),
                isHelperText: true,
                helperText:
                    'Your password must be different from previous used password.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StepPage extends StatelessWidget {
  const StepPage({
    super.key,
    required this.icon,
    required this.button,
    required this.content,
    this.helperText,
    this.isHelperText = false,
  });

  final Icon icon;
  final Widget button;
  final Widget content;
  final String? helperText;
  final bool isHelperText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE9EAF6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: icon,
            ),
            content,
            isHelperText
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      helperText ?? '',
                      style: const TextStyle(
                        color: Color(0xFF9CA4BF),
                        fontSize: 12,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Container(),
            const Spacer(),
            button,
          ],
        ),
      ),
    );
  }
}
