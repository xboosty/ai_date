import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:location/location.dart';

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
        CircularProgressIndicatorButton,
        CodeVerificationInput,
        EmailInput,
        FilledColorizedButton,
        FilledColorizedOutlineButton,
        VisibleOnProfile;
import '../screens.dart' show SignInScreen;

part 'password_register.dart';

class Genders {
  final int id;
  final String name;

  Genders({required this.id, required this.name});
}

class Sexuality {
  final int id;
  final String name;

  Sexuality({required this.id, required this.name});
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController pageviewController = PageController();
  final _notifications = getIt<HandlerNotification>();
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

  final List<Genders> _genders = [
    Genders(id: 1, name: 'Woman'),
    Genders(id: 0, name: 'Man'),
    Genders(id: 3, name: 'Non Binary'),
  ];

  final List<Sexuality> _sexualities = [
    Sexuality(id: 4, name: 'Prefer not to say'),
    Sexuality(id: 0, name: 'Hetero'),
    Sexuality(id: 1, name: 'Bisexual'),
    Sexuality(id: 2, name: 'Homosexual'),
    Sexuality(id: 3, name: 'Transexual'),
  ];

  final PhoneNumber _initialNumber = PhoneNumber(isoCode: 'US');

  final List<String> _countriesISO = [
    'US', // Estados Unidos
    'IN', // India
    'CN', // China
    'ID', // Indonesia
    'PK', // Pakistán
    'BR', // Brasil
    'NG', // Nigeria
    'BD', // Bangladesh
    'RU', // Rusia
    'MX', // México
    'JP', // Japón
    'ET', // Etiopía
    'PH', // Filipinas
    'EG', // Egipto
    'VN', // Vietnam
    'CD', // República Democrática del Congo
    'TR', // Turquía
    'IR', // Irán
    'DE', // Alemania
    'TH', // Tailandia
    'GB', // Reino Unido
    'FR', // Francia
    'TZ', // Tanzania
    'IT', // Italia
    'ZA', // Sudáfrica
    'MM', // Myanmar (Birmania)
    'KR', // Corea del Sur
    'CO', // Colombia
    'ES', // España
    'UG', // Uganda
    'AR', // Argentina
    'UA', // Ucrania
    'AL', // Albania
    'KE', // Kenia
    'SD', // Sudán
    'PL', // Polonia
    'CA', // Canadá
    'MA', // Marruecos
    'UZ', // Uzbekistán
    'MY', // Malasia
    'PE', // Perú
    'BE', // Bélgica
    'CU', // Cuba
  ];

  // Validations
  String? _validateUsername(String value) {
    // Define your validation logic here.
    if (value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 4) {
      return 'Name must be at least 4 characters long';
    }
    // if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value)) {
    //   return 'Enter a valid name Ex: jennifer95';
    // }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Enter a valid name without spaces Ex: Jennifer';
    }
    return null; // Return null if the input is valid.
  }

  String? _validatePhoneNumber(String value) {
    // Define your phone number validation logic here.
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    // You can use regular expressions or other methods to validate phone numbers.
    // Here, we're checking if the input consists of 10 digits.
    if (!RegExp(r'^\d+(?:[-\s]?\d+)*$').hasMatch(value)) {
      return 'Invalid phone number.';
    }
    return null; // Return null if the input is valid.
  }

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

  String? _validatePassword(String value) {
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

  String? _validateVerificationCode(String value) {
    if (value.isEmpty) {
      return 'Verification code is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  // For Register User
  void _submitUsername() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _username variable for further processing.
      print('Username: ${_fullNameCtrl.text}');
      _nextPage();
    }
  }

  Future<void> _submitPhoneNumber({required Size size}) async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _phoneNumber variable for further processing.
      await _submitRegisterUser(context, size: size);
    }
    // else {
    //   _notifications.ntsErrorNotification(
    //     context,
    //     message: 'The phone number must be at least 15 digits.',
    //     height: size.height * 0.12,
    //     width: size.width * 0.90,
    //   );
    //   // ElegantNotification.error(
    //   //   notificationPosition: NotificationPosition.bottomCenter,
    //   //   animation: AnimationType.fromBottom,
    //   //   background: Colors.red.shade100,
    //   //   showProgressIndicator: true,
    //   //   description: const Text(
    //   //     "",
    //   //     style: TextStyle(
    //   //       color: Colors.black,
    //   //     ),
    //   //   ),
    //   // ).show(context);
    // }
  }

  void _submitEmail() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _email variable for further processing.
      print('Email: ${_emailUserCtrl.text}');
      _nextPage();
    }
  }

  void _submitPassword() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _email variable for further processing.
      print('Password: ${_passwordCtrl.text}');
      _nextPage();
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
      "sexualOrientation": _sexualitySelected?.id ?? -1
    };
    try {
      await context.read<AccountCubit>().registerUser(user);
      _nextPage();
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
        _nextPage();
        break;
      case 2:
        _submitEmail();
        break;
      case 3:
        _submitPassword();
        break;
      case 4:
        _nextPage();
        break;
      case 5:
        _nextPage();
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

  void _nextPage() {
    pageviewController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _backPage() {
    pageviewController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _exitSetup() {
    Navigator.of(context).pop();
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
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _exitSetup(),
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
                      controller: _fullNameCtrl,
                      focusNode: _focusNodeName,
                      decoration: const InputDecoration(
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
                      validator: (value) => _validateUsername(value ?? ''),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        _submitUsername();
                      },
                      // onTap: () {
                      //   setState(() {
                      //     isShowFloatButton = false;
                      //   });
                      // },
                      // onEditingComplete: () {
                      //   setState(() {
                      //     isShowFloatButton = true;
                      //   });
                      // },
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
                              onPressed: () => _backPage(),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                              ),
                              onPressed: () => _exitSetup(),
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
                            countries: _countriesISO,
                            countrySelectorScrollControlled: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            maxLength: 15,
                            onInputChanged: (PhoneNumber number) {
                              codeNumber = number.dialCode ?? '-1';
                              phoneNumberUser = number.parseNumber();
                            },
                            validator: (value) =>
                                _validatePhoneNumber(value ?? ''),
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
                    // const Padding(
                    //   padding: EdgeInsets.only(top: 20.0),
                    //   child: Text(
                    //     'AI Date will send you a text with a verification code. Message and date rates may apply.',
                    //     style: TextStyle(
                    //       color: Color(0xFF9CA4BF),
                    //       fontSize: 12,
                    //       fontFamily: Strings.fontFamily,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageCode(Size size) {
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
                        'assets/imgs/vector_code.png',
                      ),
                    ),
                    Center(child: Image.asset('assets/imgs/code_img.png')),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        // padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _backPage(),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _exitSetup(),
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
                  'Enter your code',
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
                    CodeVerificationInput(
                      focusNode: _focusNodeVerification,
                      controller: _verificationCtrl,
                      validator: (value) =>
                          _validateVerificationCode(value ?? ''),
                      onEditingComplete: () => _focusNodeVerification.unfocus(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextButton(
                        onPressed: () =>
                            _submitRegisterUser(context, size: size),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Resend code',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
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
                              onPressed: () => _backPage(),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _exitSetup(),
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
                      validator: (value) => _validateEmail(value ?? ''),
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
                              onPressed: () => _backPage(),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _exitSetup(),
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
                validator: (value) => _validatePassword(value ?? ''),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submitPassword(),
              )
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
                            onPressed: () => _backPage(),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppTheme.disabledColor,
                              // size: 32,
                            ),
                            onPressed: () => _exitSetup(),
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
                itemCount: _genders.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    RadioListTile<Genders>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                        _genders[index].name,
                        style: const TextStyle(
                          color: Color(0xFF686E8C),
                          fontSize: 14,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: _genders[index],
                      groupValue: _genderSelected,
                      onChanged: (Genders? value) {
                        setState(() {
                          _genderSelected = value;
                        });
                      },
                    ),
                    index != _genders.length - 1
                        ? const Divider()
                        : Container(),
                  ],
                ),
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children:
              //   _genders
              //       .map(
              //         (gender) => Column(
              //           children: [
              //             RadioListTile<Genders>(
              //               controlAffinity: ListTileControlAffinity.trailing,
              //               title: Text(
              //                 gender.name,
              //                 style: const TextStyle(
              //                   color: Color(0xFF686E8C),
              //                   fontSize: 14,
              //                   fontFamily: Strings.fontFamily,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //               ),
              //               value: gender,
              //               groupValue: _genderSelected,
              //               onChanged: (Genders? value) {
              //                 setState(() {
              //                   _genderSelected = value;
              //                 });
              //               },
              //             ),
              //             gender.id != _genders.length - 3
              //                 ? const Divider()
              //                 : Container(),
              //           ],
              //         ),
              //       )
              //       .toList(),
              // ),
            ),
            VisibleOnProfile(isVisible: isGenderVisibleProfile)
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
                            onPressed: () => _backPage(),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppTheme.disabledColor,
                              // size: 32,
                            ),
                            onPressed: () => _exitSetup(),
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
                itemCount: _sexualities.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    RadioListTile<Sexuality>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                        _sexualities[index].name,
                        style: const TextStyle(
                          color: Color(0xFF686E8C),
                          fontSize: 14,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: _sexualities[index],
                      groupValue: _sexualitySelected,
                      onChanged: (Sexuality? value) {
                        setState(() {
                          _sexualitySelected = value;
                        });
                      },
                    ),
                    index != _sexualities.length - 1
                        ? const Divider()
                        : Container(),
                  ],
                ),
              ),
            ),
            VisibleOnProfile(isVisible: isSexualityVisibleProfile),
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
                          onPressed: () => _backPage(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: AppTheme.disabledColor,
                            // size: 32,
                          ),
                          onPressed: () => _exitSetup(),
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
                  onTap: () => _nextPage(),
                  // {
                  //   _formRegisterSubmit(context,
                  //       page: pageviewController.page ?? 0.0, size: size);
                  // }
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
    _nextPage();
  }

  void _pageListener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _genderSelected = _genders.first;
    _sexualitySelected = _sexualities.first;
  }

  @override
  void dispose() {
    // Page Controller Dispose
    pageviewController.removeListener(_pageListener);
    pageviewController.dispose();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Form(
          key: _formKey,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageviewController,
            onPageChanged: (index) {
              setState(() {});
            },
            children: [
              _buildPageUsername(size),
              _buildPageEmail(size),
              _buildPagePassword(size),
              _buildPageGender(size),
              _buildPageSexuality(size),
              _buildPageLocation(size),
              _buildPagePhoneNumber(size),
              _buildPageCode(size),
            ],
          ),
        ),
      ),
      floatingActionButton:
          BlocBuilder<AccountCubit, AccountState>(builder: (context, state) {
        if ((_focusNodeName.hasFocus) ||
            (_focusNodePhone.hasFocus) ||
            (_focusNodeEmail.hasFocus) ||
            (_focusNodePassword.hasFocus) ||
            (_focusNodeVerification.hasFocus)) {
          isShowFloatButton = false;
        } else {
          isShowFloatButton = true;
        }

        return switch (state.status) {
          UserRegisterStatus.loading => const CircularProgressIndicator(),
          UserRegisterStatus.initial => (isShowFloatButton)
              ? ButtonCircularProgress(
                  pageviewController: pageviewController,
                  onNextPage: (page) =>
                      _formRegisterSubmit(context, page: page, size: size),
                )
              : Container(),
          UserRegisterStatus.success => (isShowFloatButton)
              ? ButtonCircularProgress(
                  pageviewController: pageviewController,
                  onNextPage: (page) =>
                      _formRegisterSubmit(context, page: page, size: size),
                )
              : Container(),
          UserRegisterStatus.failure => (isShowFloatButton)
              ? ButtonCircularProgress(
                  pageviewController: pageviewController,
                  onNextPage: (page) =>
                      _formRegisterSubmit(context, page: page, size: size),
                )
              : Container(),
        };
      }),
    );
  }
}

class ButtonCircularProgress extends StatefulWidget {
  const ButtonCircularProgress({
    super.key,
    required this.pageviewController,
    this.onNextPage,
  });

  final PageController pageviewController;
  final ValueChanged<double>? onNextPage;

  @override
  State<ButtonCircularProgress> createState() => _ButtonCircularProgressState();
}

class _ButtonCircularProgressState extends State<ButtonCircularProgress> {
  double percent = 0.125;
  double currentPage = 0;

  void _onPressButtonPage() {
    FocusScope.of(context).unfocus();
    widget.onNextPage!(widget.pageviewController.page ?? -1);

    setState(() {
      if (widget.pageviewController.page != currentPage) {
        percent = percent + 0.125;
        currentPage = widget.pageviewController.page ?? -1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicatorButton(
      onPressed: () => _onPressButtonPage(),
      percent: percent,
      backgroundColor: const Color.fromARGB(255, 204, 66, 24),
      // percent < 1
      //     ? AppTheme.disabledColor
      //     : const Color.fromARGB(255, 204, 66, 24),
      // Relleno de color en los bordes basado en la página actual
    );
  }
}
