import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart'
    show
        AccountCubit,
        AccountState,
        AppTheme,
        HandlerNotification,
        NtsErrorResponse,
        SharedPref,
        Strings,
        UserRegisterStatus,
        getIt;
import '../../widgets/widgets.dart'
    show
        FilledColorizedOutlineButton,
        IconButtonSvg,
        PasswordInput,
        ScaffoldAnimated;
import '../screens.dart'
    show ForgotPasswordScreen, HomeScreen, IntroductionScreen;

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const String routeName = '/sign_in_screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ScaffoldAnimated(
        size: size,
        decoration: const BoxDecoration(
          gradient: AppTheme.linearGradientTopRightBottomLeft,
        ),
        child: const SignInBox(),
      ),
    );
  }
}

class SignInBox extends StatelessWidget {
  const SignInBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
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
              const SignInForm(),
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    gradient: AppTheme.linearGradientTopRightBottomLeft,
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
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const IntroductionScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideInRight(child: child);
                            },
                          ));
                          // Navigator.of(context)
                          //     .pushNamed(IntroductionScreen.routeName);
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
  final _notifications = getIt<HandlerNotification>();
  bool _obscureText = true;
  bool _isRemember = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validatePassword(String value) {
    String password = value.replaceAll(RegExp(r'\s+'), '');
    if (password.isEmpty) {
      return 'This field is required';
    } else if (password.length < 8) {
      return 'The password must be at least 8 characters.';
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
      return 'This field is required';
    } else if (!emailRegex.hasMatch(credential)) {
      return 'Please enter a valid email.';
    }

    return null;
  }

  void _forgotPassword() {
    Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
  }

  void _startSession(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      List<String> credentialsList = [];

      final credentials = {
        "email": _emailCtrl.text,
        "password": _passwordCtrl.text
      };

      if (credentials['email']!.isNotEmpty &&
          credentials['password']!.isNotEmpty) {
        credentialsList.add(credentials['email'] ?? '');
        credentialsList.add(credentials['password'] ?? '');
      }

      // Recordar credenciales en Shared Preferences
      SharedPref.pref.isRememberCredential = _isRemember;

      try {
        await context.read<AccountCubit>().signInUser(credentials);
        // Saved preference if sign in success
        if (_isRemember && credentials.isNotEmpty) {
          SharedPref.pref.loginCredential = credentialsList;
        } else if (_isRemember == false) {
          SharedPref.pref.loginCredential = [];
        }

        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => false,
        );
      } catch (e) {
        if (!mounted) return;
        if (e is NtsErrorResponse) {
          _notifications.ntsErrorNotification(
            context,
            title: "Error",
            message: e.message ?? '',
          );
        }

        if (e is DioException) {
          _notifications.errorDioNotification(context);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // SharedPreferences credentials
    List<String?> credentials = SharedPref.pref.loginCredential;
    _isRemember = SharedPref.pref.isRememberCredential;
    if (credentials.isNotEmpty) {
      _emailCtrl.text = credentials[0] ?? '';
      _passwordCtrl.text = credentials[1] ?? '';
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
                    PasswordInput(
                      controller: _passwordCtrl,
                      obscureText: _obscureText,
                      onPressedSuffixIcon: () => {
                        setState(() {
                          _obscureText = !_obscureText;
                        }),
                      },
                      validator: (value) => _validatePassword(value ?? ''),
                      labelText: 'Password',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: _isRemember,
                    onChanged: (value) {
                      setState(() {
                        _isRemember = value ?? false;
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
                    child: const Text('Forgot Password?'),
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
                    onPressed: () => _forgotPassword(),
                  ))
                ],
              ),
              SizedBox(height: size.height * 0.02),
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) => switch (state.status) {
                  UserRegisterStatus.initial => FilledColorizedOutlineButton(
                      width: 150,
                      height: 50,
                      title: 'SIGN IN',
                      isTrailingIcon: false,
                      onTap: () => _startSession(context),
                    ),
                  UserRegisterStatus.loading =>
                    const CircularProgressIndicator(),
                  UserRegisterStatus.failure => FilledColorizedOutlineButton(
                      width: 150,
                      height: 50,
                      title: 'SIGN IN',
                      isTrailingIcon: false,
                      onTap: () => _startSession(context),
                    ),
                  UserRegisterStatus.success => FilledColorizedOutlineButton(
                      width: 150,
                      height: 50,
                      title: 'SIGN IN',
                      isTrailingIcon: false,
                      onTap: () => _startSession(context),
                    ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
