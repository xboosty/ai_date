import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart'
    show
        AccountCubit,
        AccountState,
        HandlerNotification,
        NtsErrorResponse,
        Strings,
        UserRegisterStatus,
        getIt;
import '../../common/widgets/widgets.dart' show PasswordInput;

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
  final FocusNode _focusCurrentPassword = FocusNode();
  final FocusNode _focusNewPassword = FocusNode();
  final FocusNode _focusRepeatPassword = FocusNode();
  final _notifications = getIt<HandlerNotification>();

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
  void _submitChangePassword({required Size size}) async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();

      final passwords = {
        "oldPassword": currentCtrl.text,
        "password": newCtrl.text,
        "confirmationPassword": repeatCtrl.text,
      };

      try {
        await context.read<AccountCubit>().changePasswordUser(passwords);
        if (!mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        _notifications.ntsSuccessNotification(
          context,
          message: 'Password changed successfully',
          height: size.height * 0.12,
          width: size.width * 0.90,
        );
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
          bottom: false,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PasswordInput(
                        controller: currentCtrl,
                        focusNode: _focusCurrentPassword,
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
                        validator: (value) =>
                            _validateCurrentPassword(value ?? ''),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_focusNewPassword);
                        },
                      ),
                      PasswordInput(
                        controller: newCtrl,
                        focusNode: _focusNewPassword,
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
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_focusRepeatPassword);
                        },
                      ),
                      PasswordInput(
                        controller: repeatCtrl,
                        focusNode: _focusRepeatPassword,
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
                            obscureTextRepeatPassword =
                                !obscureTextRepeatPassword;
                          });
                        },
                        validator: (value) =>
                            _validateRepeatPassword(value ?? ''),
                        onEditingComplete: () => _focusRepeatPassword.unfocus(),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          _submitChangePassword(size: size);
                        },
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

                      BlocBuilder<AccountCubit, AccountState>(
                        builder: (context, state) {
                          return switch (state.status) {
                            UserRegisterStatus.initial => FilledButton(
                                onPressed: () =>
                                    _submitChangePassword(size: size),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  disabledBackgroundColor:
                                      const Color(0xFF7F87A6),
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
                              ),
                            UserRegisterStatus.loading =>
                              const CircularProgressIndicator(),
                            UserRegisterStatus.failure => FilledButton(
                                onPressed: () =>
                                    _submitChangePassword(size: size),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  disabledBackgroundColor:
                                      const Color(0xFF7F87A6),
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
                              ),
                            UserRegisterStatus.success => FilledButton(
                                onPressed: () =>
                                    _submitChangePassword(size: size),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  disabledBackgroundColor:
                                      const Color(0xFF7F87A6),
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
                              ),
                          };
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
