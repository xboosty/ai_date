import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../../widgets/widgets.dart'
    show FilledColorizedOutlineButton, IconButtonSvg, OutlineText;
import '../screens.dart' show IntroductionScreen;

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const String routeName = '/sign_in_screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: size.height,
          decoration: const BoxDecoration(
            gradient: AppTheme.linearGradientTopRightBottomLeft,
          ),
          child: Stack(
            children: [
              Positioned(
                top: -28,
                left: size.width * (0.10),
                child: const OutlineText(
                  title: 'Smarter Connections',
                  color: Colors.white,
                  fontSize: 80,
                ),
              ),
              Positioned(
                bottom: -28,
                left: size.width * (-0.05),
                child: const OutlineText(
                  title: 'Better Dates',
                  color: Colors.white,
                  fontSize: 80,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: size.width * 0.93,
                    height: size.height * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SignInForm(),
                        Expanded(
                          child: Container(
                            width: size.width,
                            decoration: const BoxDecoration(
                              gradient:
                                  AppTheme.linearGradientTopRightBottomLeft,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text(
                                  'New here?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontFamily: Strings.fontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Text(
                                  'Elevate your love life with AI Precision',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: Strings.fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const IntroductionScreen(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideInRight(child: child);
                                      },
                                    ));
                                  },
                                  child: const Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      color: Color(0xFF6C2EBC),
                                      fontSize: 16,
                                      fontFamily: Strings.fontFamily,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _obscureText = true;
  bool _isRememberPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validatePassword(String value) {
    String password = value.replaceAll(RegExp(r'\s+'), '');
    if (password.isEmpty) {
      return 'Este campo es requerido.';
    } else if (password.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    }

    return null;
  }

  // String? _validateEmail(String value) {
  //   final emailRegExp =
  //       RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  //   if (value.isEmpty) {
  //     return 'Este campo es requerido.';
  //   } else if (emailRegExp.hasMatch(value)) {
  //     return 'Introduzca un correo válido';
  //   }
  //   return null;
  // }

  String? _validateCredential(String value) {
    // Expresión regular para validar nombre de usuario o correo electrónico
    String credential = value.replaceAll(RegExp(r'\s+'), '');
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    // final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_-]{3,16}$');

    if (credential.isEmpty) {
      return 'Este campo es requerido.';
    } else if (!emailRegex.hasMatch(credential)) {
      return 'Ingresa un correo electrónico válido.';
    }

    return null;
  }

  void _startSession() async {
    if (_formKey.currentState?.validate() ?? false) {
      print('entro');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Container(
        width: size.width,
        height: size.height * 0.63,
        padding:
            const EdgeInsets.only(top: 25, bottom: 20, left: 15, right: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Sign in to AI Date',
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 28,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              const Text(
                'Log in using social networks',
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 16,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              OverflowBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButtonSvg(
                    urlSvg: 'assets/svgs/facebook_icon.svg',
                    semanticsLabel: 'Facebook Logo',
                    heroTag: 'facebookIcon',
                    backgroundColor: const Color(0xFFE9EAF6),
                    onPressed: () {},
                  ),
                  IconButtonSvg(
                    urlSvg: 'assets/svgs/apple_icon.svg',
                    semanticsLabel: 'Apple Logo',
                    heroTag: 'appleIcon',
                    backgroundColor: const Color(0xFFE9EAF6),
                    onPressed: () {},
                  ),
                  IconButtonSvg(
                    urlSvg: 'assets/svgs/google_icon.svg',
                    semanticsLabel: 'Google Logo',
                    heroTag: 'googleIcon',
                    backgroundColor: const Color(0xFFE9EAF6),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 125.50,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.5,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFF7F87A6),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: AppTheme.disabledColor,
                        fontSize: 12,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: 125.50,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.5,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFF7F87A6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                // height: size.height * 0.22,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        // hintText: 'Email',
                        labelStyle: TextStyle(
                          color: Color(0xFF7F87A6),
                          fontSize: 14,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                        errorStyle: TextStyle(
                          color: Color(0xFFC02D4F),
                          fontSize: 12,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      validator: (value) => _validateCredential(value ?? ''),
                    ),
                    // SizedBox(height: size.height * 0.02),
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                            _obscureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) => _validatePassword(value ?? ''),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: _isRememberPassword,
                    onChanged: (value) {
                      setState(() {
                        _isRememberPassword = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Remember me',
                    style: TextStyle(
                      color: Color(0xFF261638),
                      fontSize: 12,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                      child: TextButton(
                    child: Text('Forgot Password?'),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        color: Color(0xFF6C2EBC),
                        fontSize: 12,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {},
                  ))
                ],
              ),
              SizedBox(height: size.height * 0.02),
              FilledColorizedOutlineButton(
                width: 150,
                height: 50,
                title: 'SIGN IN',
                isTrailingIcon: false,
                onTap: () => _startSession(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
