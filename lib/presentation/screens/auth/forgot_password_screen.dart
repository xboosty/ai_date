import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../config/config.dart'
    show
        AccountCubit,
        AccountState,
        AppTheme,
        HandlerNotification,
        NtsErrorResponse,
        Strings,
        UserRegisterStatus,
        getIt;
import '../../widgets/widgets.dart'
    show
        CodeVerificationInput,
        EmailInput,
        FilledColorizedOutlineButton,
        PasswordInput,
        ScaffoldAnimated;
import '../screens.dart' show SignInScreen;

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  static const String routeName = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ScaffoldAnimated(
        size: size,
        decoration: const BoxDecoration(
          gradient: AppTheme.linearGradientTopRightBottomLeft,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                width: size.width * 0.93,
                height: size.height * 0.88,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // IconButton(
                                  //   icon: const Icon(
                                  //     Icons.arrow_back_rounded,
                                  //     color: Colors.white,
                                  //     size: 32,
                                  //   ),
                                  //   onPressed: () =>
                                  //       Navigator.of(context).pop(),
                                  // ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )
                                ],
                              ),
                            ),
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
                            vertical: 10.0,
                          ),
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailUserCtrl = TextEditingController();
  final TextEditingController _verificationCtrl = TextEditingController();
  final TextEditingController _passwordNewCtrl = TextEditingController();
  final TextEditingController _passwordConfirmCtrl = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeCode = FocusNode();
  final FocusNode _focusNodeNewPassword = FocusNode();
  final FocusNode _focusNodeRepitPassword = FocusNode();
  final _notifications = getIt<HandlerNotification>();

  final PageController _pageController = PageController();
  bool isObscureTextNewPassword = false;
  bool isObscureTextRepeatPassword = false;
  int _currentPage = 0;

  String? _validateEmail(String value) {
    // Define your email validation logic here.
    if (value.isEmpty) {
      return 'Email is required';
    }
    // Use a regular expression to validate the email format.
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Invalid email address';
    }
    return null; // Return null if the input is valid.
  }

  String? _validateVerificationCode(String value) {
    if (value.isEmpty) {
      return 'Verification code is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  String? _validatePasswords(String value) {
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

    // Check if the new password and repeat password it's the same.
    if (_passwordNewCtrl.text != _passwordConfirmCtrl.text) {
      return 'The new password and repeat password \nfields must be the same';
    }
    return null; // Return null if the input is valid.
  }

  void _submitEmail({required Size size}) async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      try {
        await context
            .read<AccountCubit>()
            .forgotPasswordUser(email: _emailUserCtrl.text);
        _nextPage();
      } catch (e) {
        if (!mounted) return;
        if (e is NtsErrorResponse) {
          _notifications.ntsErrorNotification(
            context,
            message: e.message ?? '',
            height: size.height * 0.12,
            width: size.width * 0.90,
          );
        }

        if (e is DioException) {
          _notifications.ntsErrorNotification(
            context,
            message: 'Sorry. Something went wrong. Please try again later',
            height: size.height * 0.12,
            width: size.width * 0.90,
          );
        }
      }
    }
  }

  Future<void> _submitVerificationCode({required Size size}) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        _nextPage();
      } catch (e) {
        if (!mounted) return;
        Navigator.of(context).pushNamed(SignInScreen.routeName);
        if (e is NtsErrorResponse) {
          _notifications.ntsErrorNotification(
            context,
            message: e.message ?? '',
            height: size.height * 0.12,
            width: size.width * 0.90,
          );
        }

        if (e is DioException) {
          _notifications.ntsErrorNotification(
            context,
            message: 'Sorry. Something went wrong. Please try again later',
            height: size.height * 0.12,
            width: size.width * 0.90,
          );
        }
      }
    }
  }

  void _submitForgotPasswords({required Size size}) async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      final recoveryCred = {
        "phone": {"code": "", "number": ""},
        "email": _emailUserCtrl.text,
        "password": _passwordNewCtrl.text,
        "confirmationPassword": _passwordConfirmCtrl.text,
        "twilioCode": _verificationCtrl.text,
      };

      try {
        await context.read<AccountCubit>().recoveryCredential(recoveryCred);
        if (!mounted) return;
        await _notifications.successRobotNotification(
          context,
          message: 'Password successfully changed for your account!',
        );
        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          SignInScreen.routeName,
          (route) => false,
        );
      } catch (e) {
        if (e is NtsErrorResponse) {
          await _notifications.errorRobotNotification(
            context,
            message: e.message ?? '',
          );
          if (!mounted) return;
          Navigator.of(context).pushNamedAndRemoveUntil(
            SignInScreen.routeName,
            (route) => false,
          );
        }

        if (e is DioException) {
          _notifications.ntsErrorNotification(
            context,
            message: 'Sorry. Something went wrong. Please try again later',
            height: size.height * 0.12,
            width: size.width * 0.90,
          );
        }
      }
    }
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _emailUserCtrl.dispose();
    _verificationCtrl.dispose();
    _passwordNewCtrl.dispose();
    _passwordConfirmCtrl.dispose();
    _pageController.dispose();
    _focusNodeEmail.dispose();
    _focusNodeCode.dispose();
    _focusNodeNewPassword.dispose();
    _focusNodeRepitPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
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
                    icon: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9EAF6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.key,
                        color: Colors.purple,
                        size: 32,
                      ),
                    ),
                    content: EmailInput(
                      controller: _emailUserCtrl,
                      focusNode: _focusNodeEmail,
                      validator: (value) => _validateEmail(value ?? ''),
                      onEditingComplete: () => _focusNodeEmail.unfocus(),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submitEmail(size: size),
                    ),
                    button: BlocBuilder<AccountCubit, AccountState>(
                      builder: (context, state) {
                        return switch (state.status) {
                          UserRegisterStatus.initial =>
                            FilledColorizedOutlineButton(
                              width: 150,
                              height: 50,
                              title: 'NEXT',
                              isTrailingIcon: false,
                              onTap: () => _submitEmail(size: size),
                            ),
                          UserRegisterStatus.loading =>
                            const CircularProgressIndicator(),
                          UserRegisterStatus.failure =>
                            FilledColorizedOutlineButton(
                              width: 150,
                              height: 50,
                              title: 'NEXT',
                              isTrailingIcon: false,
                              onTap: () => _submitEmail(size: size),
                            ),
                          UserRegisterStatus.success =>
                            FilledColorizedOutlineButton(
                              width: 150,
                              height: 50,
                              title: 'NEXT',
                              isTrailingIcon: false,
                              onTap: () => _submitEmail(size: size),
                            ),
                        };
                      },
                    ),
                    isHelperText: true,
                    helperText:
                        'Enter the email address associated with your account to reset your password.',
                  ),
                  StepPage(
                    icon: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9EAF6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.mark_as_unread,
                        color: Colors.purple,
                        size: 32,
                      ),
                    ),
                    content: CodeVerificationInput(
                      controller: _verificationCtrl,
                      focusNode: _focusNodeCode,
                      validator: (value) =>
                          _validateVerificationCode(value ?? ''),
                      onEditingComplete: () => _focusNodeCode.unfocus(),
                      onSubmitted: (value) =>
                          _submitVerificationCode(size: size),
                    ),
                    button: BlocBuilder<AccountCubit, AccountState>(
                      builder: (context, state) {
                        return switch (state.status) {
                          UserRegisterStatus.initial =>
                            FilledColorizedOutlineButton(
                              width: 150,
                              height: 50,
                              title: 'VERIFY',
                              isTrailingIcon: false,
                              onTap: () => _submitVerificationCode(size: size),
                            ),
                          UserRegisterStatus.loading =>
                            const CircularProgressIndicator(),
                          UserRegisterStatus.failure =>
                            FilledColorizedOutlineButton(
                              width: 150,
                              height: 50,
                              title: 'VERIFY',
                              isTrailingIcon: false,
                              onTap: () => _submitVerificationCode(size: size),
                            ),
                          UserRegisterStatus.success =>
                            FilledColorizedOutlineButton(
                              width: 150,
                              height: 50,
                              title: 'VERIFY',
                              isTrailingIcon: false,
                              onTap: () => _submitVerificationCode(size: size),
                            ),
                        };
                      },
                    ),
                    isHelperText: true,
                    helperText:
                        'We\'ve dispatched a verification code to your email address. Please enter it here to authenticate and secure your account.',
                  ),
                  SingleChildScrollView(
                    // height: size.height * 10,
                    child: StepPage(
                      icon: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9EAF6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          color: Colors.purple,
                          size: 32,
                        ),
                      ),
                      content: Column(
                        children: [
                          PasswordInput(
                            focusNode: _focusNodeNewPassword,
                            obscureText: isObscureTextNewPassword,
                            labelText: 'New Password',
                            controller: _passwordNewCtrl,
                            validator: (value) =>
                                _validatePasswords(value ?? ''),
                            onPressedSuffixIcon: () {
                              setState(() {
                                isObscureTextNewPassword =
                                    !isObscureTextNewPassword;
                              });
                            },
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodeRepitPassword);
                            },
                          ),
                          PasswordInput(
                            focusNode: _focusNodeRepitPassword,
                            obscureText: isObscureTextRepeatPassword,
                            labelText: 'Confirm Password',
                            controller: _passwordConfirmCtrl,
                            validator: (value) =>
                                _validatePasswords(value ?? ''),
                            onPressedSuffixIcon: () {
                              setState(() {
                                isObscureTextRepeatPassword =
                                    !isObscureTextRepeatPassword;
                              });
                            },
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) =>
                                _submitForgotPasswords(size: size),
                          ),
                        ],
                      ),
                      button: BlocBuilder<AccountCubit, AccountState>(
                        builder: (context, state) {
                          return switch (state.status) {
                            UserRegisterStatus.initial =>
                              FilledColorizedOutlineButton(
                                width: 187,
                                height: 50,
                                title: 'RESET PASSWORD',
                                isTrailingIcon: false,
                                onTap: () => _submitForgotPasswords(size: size),
                              ),
                            UserRegisterStatus.loading =>
                              const CircularProgressIndicator(),
                            UserRegisterStatus.failure =>
                              FilledColorizedOutlineButton(
                                width: 187,
                                height: 50,
                                title: 'RESET PASSWORD',
                                isTrailingIcon: false,
                                onTap: () => _submitForgotPasswords(size: size),
                              ),
                            UserRegisterStatus.success =>
                              FilledColorizedOutlineButton(
                                width: 187,
                                height: 50,
                                title: 'RESET PASSWORD',
                                isTrailingIcon: false,
                                onTap: () => _submitForgotPasswords(size: size),
                              ),
                          };
                        },
                      ),
                      isHelperText: true,
                      helperText:
                          'Your password must be different from previous used password.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  final Widget icon;
  final Widget button;
  final Widget content;
  final String? helperText;
  final bool isHelperText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
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
            button,
          ],
        ),
      ),
    );
  }
}
