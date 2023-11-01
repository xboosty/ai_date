import 'package:ai_date/presentation/screens/register/register_screen/constants/constants.dart';
import 'package:ai_date/presentation/screens/register/register_screen/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:location/location.dart';

import '../../../../config/config.dart'
    show
        AccountCubit,
        AccountState,
        AppTheme,
        Genders,
        HandlerNotification,
        NavigationsApp,
        NtsErrorResponse,
        Sexuality,
        Strings,
        UserRegisterStatus,
        getIt;
import '../../../widgets/widgets.dart'
    show
        EmailInput,
        FilledColorizedButton,
        FilledColorizedOutlineButton,
        VisibleOnProfile;
import '../../screens.dart' show SignInScreen;
import 'steps/code_verification_step.dart';
import 'widgets/button_circular_progress.dart';

part '../password_register.dart';

class RegisterScreenArguments {
  final UserCredential? firebaseUserCredential;

  RegisterScreenArguments(this.firebaseUserCredential);
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register_screen';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as RegisterScreenArguments?;
    return RegisterView(
      firebaseUserCredential: args?.firebaseUserCredential,
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
    this.firebaseUserCredential,
  });

  final UserCredential? firebaseUserCredential;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController pageviewController = PageController();
  final _notifications = getIt<HandlerNotification>();
  final _navigations = getIt<NavigationsApp>();
  final TextEditingController _fullNameCtrl = TextEditingController();
  final TextEditingController _emailUserCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _verificationCtrl = TextEditingController();
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodePhone = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeVerification = FocusNode();

  bool isShowFloatButton = true;
  bool isLastPage = false;
  bool isNotifyPage = false;
  bool isGenderVisibleProfile = false;
  bool isSexualityVisibleProfile = false;
  String phoneNumberUser = '';
  String codeNumber = '';

  late Genders? _genderSelected;
  late Sexuality? _sexualitySelected;

  final PhoneNumber _initialNumber = PhoneNumber(isoCode: 'US');

  // For Register User
  void _submitUsername() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _username variable for further processing.
      print('Username: ${_fullNameCtrl.text}');
      _navigations.nextPage(pageviewController: pageviewController);
    }
  }

  Future<void> _submitPhoneNumber({required Size size}) async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _phoneNumber variable for further processing.
      await _submitRegisterUser(context, size: size);
    }
  }

  void _submitEmail() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _email variable for further processing.
      print('Email: ${_emailUserCtrl.text}');
      _navigations.nextPage(pageviewController: pageviewController);
    }
  }

  void _submitPassword() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _email variable for further processing.
      print('Password: ${_passwordCtrl.text}');
      _navigations.nextPage(pageviewController: pageviewController);
    }
  }

  Future<void> _submitRegisterUser(BuildContext context,
      {required Size size}) async {
    final user = {
      "fullName": _fullNameCtrl.text,
      "password": _passwordCtrl.text,
      "confirmationPassword": _passwordCtrl.text,
      "email": _emailUserCtrl.text,
      "birthday": "2023-10-07T05:16:16.305Z",
      "phone": {"code": codeNumber, "number": phoneNumberUser},
      "gender": _genderSelected?.id ?? -1,
      "sexualOrientation": _sexualitySelected?.id ?? -1,
      "isGenderVisible": isGenderVisibleProfile,
      "isSexualityVisible": isSexualityVisibleProfile,
    };
    try {
      await context.read<AccountCubit>().registerUser(user);
      _navigations.nextPage(pageviewController: pageviewController);
    } catch (e) {
      if (!mounted) return;
      if (e is NtsErrorResponse) {
        await _notifications.ntsErrorNotification(
          context,
          message: e.message ?? '',
          height: size.height * 0.12,
          width: size.width * 0.90,
        );
      }

      if (!mounted) return;
      if (e is DioException) {
        await _notifications.ntsErrorNotification(
          context,
          message: 'Sorry. Something went wrong. Please try again later',
          height: size.height * 0.12,
          width: size.width * 0.90,
        );
      }
    }
  }

  Future<void> _submitVerificationCode(BuildContext context,
      {required Size size}) async {
    if (_formKey.currentState!.validate()) {
      final verification = {
        "phone": {"code": codeNumber, "number": phoneNumberUser},
        "email": "",
        "verificationCode": _verificationCtrl.text
      };

      try {
        await context.read<AccountCubit>().verificationCode(verification);
        if (!mounted) return;
        await _notifications.successRobotNotification(
          context,
          message:
              'Congratulation. Your account has been created with success.',
        );
        if (!mounted) return;
        Navigator.of(context).pushNamed(SignInScreen.routeName);
      } catch (e) {
        if (!mounted) return;
        if (e is NtsErrorResponse) {
          await _notifications.errorRobotNotification(
            context,
            message: e.message ?? '',
          );
        }
        if (!mounted) return;
        if (e is DioException) {
          await _notifications.ntsErrorNotification(
            context,
            message: 'Sorry. Something went wrong. Please try again later',
            height: size.height * 0.12,
            width: size.width * 0.90,
          );
        }
      }
    }
  }

  Future<void> _formRegisterSubmit(BuildContext context,
      {required double page, required Size size}) async {
    switch (page) {
      case 0:
        _submitUsername();
        break;
      case 1:
        _submitEmail();
        break;
      case 2:
        _submitPassword();
        break;
      case 3:
        _navigations.nextPage(pageviewController: pageviewController);
        break;
      case 4:
        _navigations.nextPage(pageviewController: pageviewController);
        break;
      case 5:
        widget.firebaseUserCredential == null
            ? _navigations.nextPage(pageviewController: pageviewController)
            : () {};
        break;
      case 6:
        await _submitPhoneNumber(size: size);
        break;
      case 7:
        if (!mounted) return;
        await _submitVerificationCode(context, size: size);
        break;
      default:
        break;
    }
  }

  Widget _buildPageUsername(Size size) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.36,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/imgs/vector_robot_chat.png',
                      ),
                    ),
                    Center(child: Image.asset('assets/imgs/robot_chat.png')),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Navigator.of(context).pop();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () {
                                _navigations.exitSetup(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height / 40),
                child: const Text(
                  'What\'s your name?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF261638),
                    fontSize: 28,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      textCapitalization: TextCapitalization.none,
                      controller: _fullNameCtrl,
                      focusNode: _focusNodeName,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                        errorMaxLines: 2,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF686E8C),
                            width: 2.0,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF686E8C),
                            width: 2.0,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF686E8C),
                        fontSize: 24,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) =>
                          RegisterValidators.validateUsername(value ?? ''),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        _submitUsername();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'This is how it\'ll appear on your profile',
                        style: TextStyle(
                          color: Color(0xFF9CA4BF),
                          fontSize: 12,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPagePhoneNumber(Size size) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.36,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/imgs/vector_phone_number.png',
                      ),
                    ),
                    Center(
                      child: Image.asset('assets/imgs/phone_number_img.png'),
                    ),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppTheme.disabledColor,
                              ),
                              onPressed: () => _navigations.backPage(context,
                                  pageviewController: pageviewController),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                              ),
                              onPressed: () => _navigations.exitSetup(context),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height / 40),
                child: const Text(
                  'What\'s your phone number?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF261638),
                    fontSize: 28,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.90,
                          child: InternationalPhoneNumberInput(
                            focusNode: _focusNodePhone,
                            initialValue: _initialNumber,
                            countries: RegisterConstants.countriesISO,
                            countrySelectorScrollControlled: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            maxLength: 15,
                            onInputChanged: (PhoneNumber number) {
                              codeNumber = number.dialCode ?? '-1';
                              phoneNumberUser = number.parseNumber();
                            },
                            validator: (value) =>
                                RegisterValidators.validatePhoneNumber(
                                    value ?? ''),
                            onFieldSubmitted: (_) =>
                                _submitPhoneNumber(size: size),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'AI Date will send you a text with a verification code. Message and date rates may apply.',
                        style: TextStyle(
                          color: Color(0xFF9CA4BF),
                          fontSize: 12,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageEmail(Size size) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.36,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/imgs/vector_email.png',
                      ),
                    ),
                    Center(child: Image.asset('assets/imgs/email_img.png')),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _navigations.backPage(context,
                                  pageviewController: pageviewController),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _navigations.exitSetup(context),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height / 40),
                child: const Text(
                  'What\'s your email address?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF261638),
                    fontSize: 28,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmailInput(
                      controller: _emailUserCtrl,
                      focusNode: _focusNodeEmail,
                      validator: (value) =>
                          RegisterValidators.validateEmail(value ?? ''),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submitEmail(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPagePassword(Size size) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.36,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                // color: Colors.red,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/imgs/vector_password.png',
                      ),
                    ),
                    Center(child: Image.asset('assets/imgs/password_img.png')),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _navigations.backPage(context,
                                  pageviewController: pageviewController),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _navigations.exitSetup(context),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height / 40),
                child: const Text(
                  'Set your account password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF261638),
                    fontSize: 28,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              PasswordRegister(
                passwordCtrl: _passwordCtrl,
                focusNodePassword: _focusNodePassword,
                validator: (value) =>
                    RegisterValidators.validatePassword(value ?? ''),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submitPassword(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageGender(Size size) {
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/imgs/vector_gender.png',
                    ),
                  ),
                  Center(child: Image.asset('assets/imgs/gender_img.png')),
                  SafeArea(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppTheme.disabledColor,
                              // size: 32,
                            ),
                            onPressed: () => _navigations.backPage(context,
                                pageviewController: pageviewController),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppTheme.disabledColor,
                              // size: 32,
                            ),
                            onPressed: () => _navigations.exitSetup(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height / 40),
              child: const Text(
                'What\'s your gender',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 28,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              height: size.height * 0.32,
              padding: EdgeInsets.symmetric(horizontal: size.width / 20),
              child: ListView.builder(
                itemCount: RegisterConstants.genders.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    RadioListTile<Genders>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                        RegisterConstants.genders[index].name,
                        style: const TextStyle(
                          color: Color(0xFF686E8C),
                          fontSize: 14,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: RegisterConstants.genders[index],
                      groupValue: _genderSelected,
                      onChanged: (Genders? value) {
                        setState(() {
                          _genderSelected = value;
                        });
                      },
                    ),
                    index != RegisterConstants.genders.length - 1
                        ? const Divider()
                        : Container(),
                  ],
                ),
              ),
            ),
            VisibleOnProfile(
              isVisible: isGenderVisibleProfile,
              onChangedValue: (value) {
                isGenderVisibleProfile = value ?? false;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageSexuality(Size size) {
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              // color: Colors.red,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/imgs/vector_heart.png',
                    ),
                  ),
                  Center(child: Image.asset('assets/imgs/heart_img.png')),
                  SafeArea(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppTheme.disabledColor,
                              // size: 32,
                            ),
                            onPressed: () => _navigations.backPage(context,
                                pageviewController: pageviewController),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppTheme.disabledColor,
                              // size: 32,
                            ),
                            onPressed: () => _navigations.exitSetup(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height / 40),
              child: const Text(
                'What\'s your sexuality?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 28,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              height: size.height * 0.38,
              padding: EdgeInsets.symmetric(horizontal: size.width / 20),
              child: ListView.builder(
                itemCount: RegisterConstants.sexualities.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    RadioListTile<Sexuality>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                        RegisterConstants.sexualities[index].name,
                        style: const TextStyle(
                          color: Color(0xFF686E8C),
                          fontSize: 14,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: RegisterConstants.sexualities[index],
                      groupValue: _sexualitySelected,
                      onChanged: (Sexuality? value) {
                        setState(() {
                          _sexualitySelected = value;
                        });
                      },
                    ),
                    index != RegisterConstants.sexualities.length - 1
                        ? const Divider()
                        : Container(),
                  ],
                ),
              ),
            ),
            VisibleOnProfile(
              isVisible: isSexualityVisibleProfile,
              onChangedValue: (value) {
                isSexualityVisibleProfile = value ?? false;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageLocation(Size size) {
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.36,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            // color: Colors.red,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/imgs/vector_location.png',
                  ),
                ),
                Center(child: Image.asset('assets/imgs/location_img.png')),
                SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppTheme.disabledColor,
                            // size: 32,
                          ),
                          onPressed: () => _navigations.backPage(
                            context,
                            pageviewController: pageviewController,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: AppTheme.disabledColor,
                            // size: 32,
                          ),
                          onPressed: () => _navigations.exitSetup(context),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height / 40),
            child: const Text(
              'Location access required',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF261638),
                fontSize: 28,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width / 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledColorizedButton(
                  width: size.width * 0.90,
                  height: size.height * 0.08,
                  title: 'ALLOW LOCATION ACCESS',
                  isTrailingIcon: false,
                  onTap: () async => await _accessLocation(),
                  icon: const Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                FilledColorizedOutlineButton(
                  width: size.width * 0.90,
                  height: size.height * 0.08,
                  title: 'DON\'T ALLOW',
                  isTrailingIcon: false,
                  onTap: () => _navigations.nextPage(
                      pageviewController: pageviewController),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'To provide you with the best experience, AI Date needs access to your device\'s location. This will help us tailor our services to your specific location and enhance your user experience. You can change this later in your settings.',
                    style: TextStyle(
                      color: Color(0xFF9CA4BF),
                      fontSize: 12,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w500,
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

  Future<void> _accessLocation() async {
    final Location location = Location();

    bool serviceEnabled = false;
    PermissionStatus permissionGranted;
    // LocationData _locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _navigations.nextPage(pageviewController: pageviewController);
  }

  void _pageListener() {
    setState(() {});
  }

  @override
  void initState() {
    _fullNameCtrl.text = widget.firebaseUserCredential?.user?.displayName ?? '';
    _genderSelected = RegisterConstants.genders.first;
    _sexualitySelected = RegisterConstants.sexualities.first;
    super.initState();
  }

  @override
  void dispose() {
    // TextEditing Dispose
    _fullNameCtrl.dispose();
    _emailUserCtrl.dispose();
    _passwordCtrl.dispose();
    _verificationCtrl.dispose();
    // Focus Node Dispose
    _focusNodeName.dispose();
    _focusNodePhone.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeVerification.dispose();
    // Page Controller Dispose
    pageviewController.removeListener(_pageListener);
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final steps = widget.firebaseUserCredential == null
        ? [
            _buildPageUsername(size),
            _buildPageEmail(size),
            _buildPagePassword(size),
            _buildPageGender(size),
            _buildPageSexuality(size),
            _buildPageLocation(size),
            _buildPagePhoneNumber(size),
            CodeVerificationStep(
              pageviewController: pageviewController,
              focusNodeVerification: _focusNodeVerification,
              verificationCtrl: _verificationCtrl,
              onPressed: () => _submitRegisterUser(context, size: size),
            ),
          ]
        : [
            _buildPageUsername(size),
            _buildPageGender(size),
            _buildPageSexuality(size),
            _buildPageLocation(size),
          ];
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Form(
          key: _formKey,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageviewController,
            children: steps,
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if ((_focusNodeName.hasFocus) ||
              (_focusNodePhone.hasFocus) ||
              (_focusNodeEmail.hasFocus) ||
              (_focusNodePassword.hasFocus) ||
              (_focusNodeVerification.hasFocus)) {
            isShowFloatButton = false;
          } else {
            isShowFloatButton = true;
          }

          return state.status == UserRegisterStatus.loading
              ? Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.all(10.0),
                  child: const CircularProgressIndicator(),
                )
              : (isShowFloatButton)
                  ? ButtonCircularProgress(
                      pageviewController: pageviewController,
                      pagesLength: steps.length,
                      onNextPage: (page) =>
                          _formRegisterSubmit(context, page: page, size: size),
                    )
                  : Container();
        },
      ),
    );
  }
}
