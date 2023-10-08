import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../config/config.dart'
    show AccountCubit, AppTheme, Strings, UserRegisterStatus;
import '../../widgets/widgets.dart'
    show
        CircularProgressIndicatorButton,
        CodeVerificationInput,
        EmailInput,
        FilledColorizedButton,
        FilledColorizedOutlineButton,
        VisibleOnProfile;
import '../screens.dart' show HomeScreen, SignInScreen;

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

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const String routeName = '/onboarding_screen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController pageviewController = PageController();
  final TextEditingController _fullNameCtrl = TextEditingController();
  final TextEditingController _emailUserCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _verificationCtrl = TextEditingController();

  bool isLastPage = false;
  bool isNotifyPage = false;
  bool isGenderVisibleProfile = false;
  bool isSexualityVisibleProfile = false;
  String phoneNumberUser = '';
  String codeNumber = '';

  int _currentPage = 0;
  late Genders? _genderSelected;
  late Sexuality? _sexualitySelected;

  final List<Genders> _genders = [
    Genders(id: 3, name: 'Non Binary'),
    Genders(id: 2, name: 'Woman'),
    Genders(id: 1, name: 'Man'),
  ];

  final List<Sexuality> _sexualities = [
    Sexuality(id: 1, name: 'Prefer not to say'),
    Sexuality(id: 2, name: 'Straight'),
    Sexuality(id: 3, name: 'Gay'),
    Sexuality(id: 4, name: 'Lesbian'),
    Sexuality(id: 5, name: 'Bisexual'),
    Sexuality(id: 6, name: 'Transgender'),
  ];

  // Validations
  String? _validateUsername(String value) {
    // Define your validation logic here.
    if (value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 4) {
      return 'Username must be at least 4 characters long';
    }
    // You can add more validation rules as needed.
    return null; // Return null if the input is valid.
  }

  String? _validatePhoneNumber(String value) {
    // Define your phone number validation logic here.
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    // You can use regular expressions or other methods to validate phone numbers.
    // Here, we're checking if the input consists of 10 digits.
    // if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
    //   return 'Invalid phone number. Please enter 10 digits.';
    // }
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
  Future<void> _verificationCode(BuildContext context) async {
    final verification = {
      "phone": {"code": codeNumber, "number": phoneNumberUser},
      "email": "",
      "verificationCode": _verificationCtrl.text
    };

    await context.read<AccountCubit>().verificationCode(verification);
  }

  Future<void> _registerUser(BuildContext context) async {
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

    await context.read<AccountCubit>().registerUser(user);
  }

  void _submitUsername() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _username variable for further processing.
      print('Username: ${_fullNameCtrl.text}');
      _netxPage();
    }
  }

  void _submitPhoneNumber() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _phoneNumber variable for further processing.
      print('Phone Number: $phoneNumberUser');
      _netxPage();
    }
  }

  void _submitEmail() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _email variable for further processing.
      print('Email: ${_emailUserCtrl.text}');
      _netxPage();
    }
  }

  void _submitPassword() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form and perform an action.
      _formKey.currentState!.save();
      // Here, you can use the _email variable for further processing.
      print('Password: ${_passwordCtrl.text}');
      _netxPage();
    }
  }

  Future<void> _formRegisterSubmit(BuildContext context,
      {required double page}) async {
    switch (page) {
      case 0:
        _submitUsername();
        break;
      case 1:
        _submitPhoneNumber();
        break;
      case 2:
        _submitEmail();
        break;
      case 3:
        _submitPassword();
        break;
      case 4:
        _netxPage();
        break;
      case 5:
        _netxPage();
        break;
      case 6:
        await _registerUser(context);
        _netxPage();
        break;
      case 7:
        if (!mounted) return;
        await _verificationCode(context);
        break;
      default:
        break;
    }
  }

  void _netxPage() {
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
    return Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              // color: Colors.red,
              child: Container(
                // color: Colors.white,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/imgs/vector_robot_chat.png',
                      ),
                    ),
                    Center(child: Image.asset('assets/imgs/robot_chat.png')),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppTheme.disabledColor,
                              size: 32,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppTheme.disabledColor,
                              size: 32,
                            ),
                            onPressed: () => _exitSetup(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
    );
  }

  Widget _buildPagePhoneNumber(Size size) {
    return Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppTheme.disabledColor,
                            size: 32,
                          ),
                          onPressed: () => _backPage(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: AppTheme.disabledColor,
                            size: 32,
                          ),
                          onPressed: () => _exitSetup(),
                        )
                      ],
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
                        // height: size.height * 0.20,
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            codeNumber = number.dialCode ?? '-1';
                            phoneNumberUser = number.parseNumber();
                          },
                          validator: (value) =>
                              _validatePhoneNumber(value ?? ''),
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
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
    );
  }

  Widget _buildPageCode(Size size, bool isVerify) {
    return Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              // color: Colors.red,
              child: Container(
                // color: Colors.white,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/imgs/vector_code.png',
                      ),
                    ),
                    Center(child: Image.asset('assets/imgs/code_img.png')),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppTheme.disabledColor,
                              size: 32,
                            ),
                            onPressed: () => _backPage(),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppTheme.disabledColor,
                              size: 32,
                            ),
                            onPressed: () => _exitSetup(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
                    controller: _verificationCtrl,
                    validator: (value) =>
                        _validateVerificationCode(value ?? ''),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TextButton(
                      onPressed: () {},
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
            isVerify ? SizedBox(height: size.height * 0.20) : Container(),
            isVerify
                ? FilledColorizedButton(
                    width: size.width * 0.80,
                    height: size.height * 0.10,
                    title: 'GETTING STARTED!',
                    isTrailingIcon: false,
                    onTap: () =>
                        Navigator.of(context).pushNamed(HomeScreen.routeName),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageEmail(Size size) {
    return Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              // color: Colors.red,
              child: Container(
                // color: Colors.white,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/imgs/vector_email.png',
                      ),
                    ),
                    Center(child: Image.asset('assets/imgs/email_img.png')),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppTheme.disabledColor,
                              size: 32,
                            ),
                            onPressed: () => _backPage(),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppTheme.disabledColor,
                              size: 32,
                            ),
                            onPressed: () => _exitSetup(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
                    validator: (value) => _validateEmail(value ?? ''),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 20.0),
                  //   child: Text(
                  //     'This is how it´ll appear on your profile',
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
    );
  }

  Widget _buildPagePassword(Size size) {
    return Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              // color: Colors.red,
              child: Container(
                // color: Colors.white,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/imgs/vector_password.png',
                      ),
                    ),
                    Center(child: Image.asset('assets/imgs/password_img.png')),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppTheme.disabledColor,
                              size: 32,
                            ),
                            onPressed: () => _backPage(),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppTheme.disabledColor,
                              size: 32,
                            ),
                            onPressed: () => _exitSetup(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _passwordCtrl,
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
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => _validatePassword(value ?? ''),
                  ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageGender(Size size) {
    return Container(
      width: double.infinity,
      height: size.height,
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.36,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            // color: Colors.red,
            child: Container(
              // color: Colors.white,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/imgs/vector_gender.png',
                    ),
                  ),
                  Center(child: Image.asset('assets/imgs/gender_img.png')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppTheme.disabledColor,
                            size: 32,
                          ),
                          onPressed: () => _backPage(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: AppTheme.disabledColor,
                            size: 32,
                          ),
                          onPressed: () => _exitSetup(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
            padding: EdgeInsets.symmetric(horizontal: size.width / 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _genders
                  .map(
                    (gender) => Column(
                      children: [
                        RadioListTile<Genders>(
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text(
                            gender.name,
                            style: const TextStyle(
                              color: Color(0xFF686E8C),
                              fontSize: 14,
                              fontFamily: Strings.fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          value: gender,
                          groupValue: _genderSelected,
                          onChanged: (Genders? value) {
                            setState(() {
                              _genderSelected = value;
                            });
                          },
                        ),
                        gender.id != 1 ? const Divider() : Container(),
                      ],
                    ),
                  )
                  .toList(),

              // [
              //   RadioListTile<Genders>(
              //     title: const Text('Lafayette'),
              //     value: _genders[0],
              //     groupValue: _genderSelected,
              //     onChanged: (Genders? value) {
              //       setState(() {
              //         _genderSelected = value;
              //       });
              //     },
              //   ),
              //   RadioListTile<Genders>(
              //     title: const Text('Thomas Jefferson'),
              //     value: _genders[1],
              //     groupValue: _genderSelected,
              //     onChanged: (Genders? value) {
              //       setState(() {
              //         _genderSelected = value;
              //       });
              //     },
              //   ),
              //   RadioListTile<Genders>(
              //     title: const Text('Thomas Jefferson'),
              //     value: _genders[2],
              //     groupValue: _genderSelected,
              //     onChanged: (Genders? value) {
              //       setState(() {
              //         _genderSelected = value;
              //       });
              //     },
              //   ),
              // ],
            ),
          ),
          VisibleOnProfile(isVisible: isGenderVisibleProfile)
        ],
      ),
    );
  }

  Widget _buildPageSexuality(Size size) {
    return Container(
      width: double.infinity,
      height: size.height,
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.36,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            // color: Colors.red,
            child: Container(
              // color: Colors.white,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/imgs/vector_heart.png',
                    ),
                  ),
                  Center(child: Image.asset('assets/imgs/heart_img.png')),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppTheme.disabledColor,
                            size: 32,
                          ),
                          onPressed: () => _backPage(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: AppTheme.disabledColor,
                            size: 32,
                          ),
                          onPressed: () => _exitSetup(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
            // color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: size.width / 20),
            child: ListView.builder(
              itemCount: 5,
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
                  Divider(),
                ],
              ),
            ),
          ),
          VisibleOnProfile(isVisible: isSexualityVisibleProfile),
        ],
      ),
    );
  }

  Widget _buildPageLocation(Size size) {
    return Container(
      width: double.infinity,
      height: size.height,
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.36,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            // color: Colors.red,
            child: Container(
              // color: Colors.white,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/imgs/vector_location.png',
                    ),
                  ),
                  Center(child: Image.asset('assets/imgs/location_img.png')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppTheme.disabledColor,
                            size: 32,
                          ),
                          onPressed: () => _backPage(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: AppTheme.disabledColor,
                            size: 32,
                          ),
                          onPressed: () => _exitSetup(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(SignInScreen.routeName),
                ),
                SizedBox(height: size.height * 0.02),
                FilledColorizedOutlineButton(
                  width: size.width * 0.90,
                  height: size.height * 0.08,
                  title: 'DON\'T ALLOW',
                  isTrailingIcon: false,
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

  void _pageListener() {
    setState(() {
      _currentPage = pageviewController.page!.round();
    });
  }

  @override
  void initState() {
    super.initState();
    _genderSelected = _genders.first;
    _sexualitySelected = _sexualities.first;
  }

  @override
  void dispose() {
    pageviewController.removeListener(_pageListener);
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final account = context.watch<AccountCubit>();

    return SafeArea(
      child: Scaffold(
          body: Form(
            key: _formKey,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageviewController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  print(_currentPage);
                  // isLastPage = index == 3;
                  // isNotifyPage = index == 1;
                });
              },
              children: [
                _buildPageUsername(size),
                _buildPagePhoneNumber(size),
                _buildPageEmail(size),
                _buildPagePassword(size),
                _buildPageGender(size),
                _buildPageSexuality(size),
                _buildPageLocation(size),
                _buildPageCode(size, account.state.isVerify ?? false),
              ],
            ),
          ),
          // floatingActionButton: const CircularProgressIndicator(
          //   backgroundColor: AppTheme.disabledColor,
          //   valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          // )
          floatingActionButton: switch (account.state.status) {
            UserRegisterStatus.loading => CircularProgressIndicator(),
            // TODO: Handle this case.
            UserRegisterStatus.initial => ButtonCircularProgress(
                pageviewController: pageviewController,
                onNextPage: (page) => _formRegisterSubmit(context, page: page),
              ),
            // TODO: Handle this case.
            UserRegisterStatus.success => Container(),
            // TODO: Handle this case.
            UserRegisterStatus.failure => Container(
                height: 50,
                width: 100,
                color: Colors.red.shade200,
                child: const Text('Error'),
              ),
          }

          // account.state.status == UserRegisterStatus.loading
          //     ? ButtonCircularProgress(
          //         pageviewController: pageviewController,
          //         onNextPage: (page) => _formRegisterSubmit(context, page: page),
          //       )
          //     : null,
          ),
      // bottomSheet: isLastPage
      //     ? TextButton(
      //         onPressed: () async {
      //           // Navigate to Home Page with init App
      //           // SharedPref.pref.showLogin = true;

      //           // ignore: use_build_context_synchronously
      //           // Navigator.of(context)
      //           //     .pushReplacementNamed(SignInScreen.routeName);
      //         },
      //         style: TextButton.styleFrom(
      //           // shape: RoundedRectangleBorder(
      //           //   borderRadius: BorderRadius.circular(5.0),
      //           // ),
      //           // foregroundColor: Colors.white,
      //           // backgroundColor: Colors.teal.shade700,
      //           minimumSize: const Size.fromHeight(80),
      //         ),
      //         child: const Text(
      //           'EMPECEMOS',
      //           style: TextStyle(fontSize: 24),
      //         ),
      //       )
      //     : Container(
      //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //         height: 80.0,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             TextButton(
      //               onPressed: () async {
      //                 // Allow Notify
      //                 // await PermissionNotify.notification.allowNotification();

      //                 pageviewController.jumpToPage(3);
      //               },
      //               child: const Text('SALTAR'),
      //             ),
      //             // Center(
      //             //   child: SmoothPageIndicator(
      //             //     controller: pageviewController,
      //             //     count: 4,
      //             //     effect: WormEffect(
      //             //       spacing: 16,
      //             //       dotColor: Colors.grey.shade300,
      //             //       activeDotColor: AppColors.secondaryColor,
      //             //     ),
      //             //     onDotClicked: (index) => pageviewController.animateToPage(
      //             //       index,
      //             //       duration: const Duration(milliseconds: 500),
      //             //       curve: Curves.easeIn,
      //             //     ),
      //             //   ),
      //             // ),
      //             // TextButton(
      //             //   onPressed: () async {
      //             //     if (isNotifyPage) {
      //             //       await PermissionNotify.notification.allowNotification();
      //             //     }

      //             //     pageviewController.nextPage(
      //             //         duration: const Duration(milliseconds: 500),
      //             //         curve: Curves.easeInOut);
      //             //   },
      //             //   child: const Text('SIGUIENTE'),
      //             // ),
      //           ],
      //         ),
      //       ),
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
      backgroundColor: percent < 1
          ? AppTheme.disabledColor
          : Color.fromARGB(255, 204, 66, 24),
      // Relleno de color en los bordes basado en la página actual
    );
  }
}
