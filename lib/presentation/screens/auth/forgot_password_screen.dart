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
import '../screens.dart' show SignInScreen, SuccessChangePasswordScreen;

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
                                  onPressed: () => Navigator.of(context).pop(),
                                )
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_downward, color: Colors.white),
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

  void _submitEmail() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();

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

  Future<void> _submitVerificationCode() async {
    if (_formKey.currentState!.validate()) {
      // final verification = {
      //   "phone": {"code": "", "number": ""},
      //   "email": "",
      //   "verificationCode": _verificationCtrl.text
      // };

      try {
        // await context.read<AccountCubit>().verificationCode(verification);
        _nextPage();
      } catch (e) {
        if (!mounted) return;
        Navigator.of(context).pushNamed(SignInScreen.routeName);
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

  void _submitForgotPasswords() async {
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
        Navigator.of(context).pushNamedAndRemoveUntil(
            SuccessChangePasswordScreen.routeName, (route) => false);
      } catch (e) {
        if (!mounted) return;
        Navigator.of(context).pushNamed(SignInScreen.routeName);
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

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
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
                    child: Icon(
                      Icons.key,
                      color: Colors.purple,
                      size: 32,
                    ),
                  ),
                  content: EmailInput(
                    controller: _emailUserCtrl,
                    validator: (value) => _validateEmail(value ?? ''),
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
                            onTap: () => _submitEmail(),
                          ),
                        UserRegisterStatus.loading =>
                          const CircularProgressIndicator(),
                        UserRegisterStatus.failure =>
                          FilledColorizedOutlineButton(
                            width: 150,
                            height: 50,
                            title: 'NEXT',
                            isTrailingIcon: false,
                            onTap: () => _submitEmail(),
                          ),
                        UserRegisterStatus.success =>
                          FilledColorizedOutlineButton(
                            width: 150,
                            height: 50,
                            title: 'NEXT',
                            isTrailingIcon: false,
                            onTap: () => _submitEmail(),
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
                    validator: (value) =>
                        _validateVerificationCode(value ?? ''),
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
                            onTap: () => _submitVerificationCode(),
                          ),
                        UserRegisterStatus.loading =>
                          const CircularProgressIndicator(),
                        UserRegisterStatus.failure =>
                          FilledColorizedOutlineButton(
                            width: 150,
                            height: 50,
                            title: 'VERIFY',
                            isTrailingIcon: false,
                            onTap: () => _submitVerificationCode(),
                          ),
                        UserRegisterStatus.success =>
                          FilledColorizedOutlineButton(
                            width: 150,
                            height: 50,
                            title: 'VERIFY',
                            isTrailingIcon: false,
                            onTap: () => _submitVerificationCode(),
                          ),
                      };
                    },
                  ),
                  isHelperText: true,
                  helperText:
                      'We\'ve dispatched a verification code to your email address. Please enter it here to authenticate and secure your account.',
                ),
                SingleChildScrollView(
                  child: SizedBox(
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
                          ),
                          PasswordInput(
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
                                onTap: () => _submitForgotPasswords(),
                              ),
                            UserRegisterStatus.loading =>
                              const CircularProgressIndicator(),
                            UserRegisterStatus.failure =>
                              FilledColorizedOutlineButton(
                                width: 187,
                                height: 50,
                                title: 'RESET PASSWORD',
                                isTrailingIcon: false,
                                onTap: () => _submitForgotPasswords(),
                              ),
                            UserRegisterStatus.success =>
                              FilledColorizedOutlineButton(
                                width: 187,
                                height: 50,
                                title: 'RESET PASSWORD',
                                isTrailingIcon: false,
                                onTap: () => _submitForgotPasswords(),
                              ),
                          };
                        },
                      ),
                      isHelperText: true,
                      helperText:
                          'Your password must be different from previous used password.',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
    final size = MediaQuery.of(context).size;

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
