import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../../widgets/widgets.dart'
    show
        FilledColorizedOutlineButton,
        VisibleOnProfile,
        WelcomeText,
        CircularProgressIndicatorButton,
        FilledColorizedButton;
import '../screens.dart' show IntroductionScreen, SignInScreen;

class Genders {
  final String id;
  final String name;

  Genders({required this.id, required this.name});
}

class Sexuality {
  final String id;
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
  final pageviewController = PageController();
  bool isLastPage = false;
  bool isNotifyPage = false;
  bool isGenderVisibleProfile = false;
  bool isSexualityVisibleProfile = false;
  double _percent = 0.0;

  int _currentPage = 0;
  late Genders? _genderSelected;
  late Sexuality? _sexualitySelected;

  final List<Color> _buttonBorderColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.brown,
    Colors.indigo,
    Colors.lightBlue,
    Colors.yellow,
    Colors.yellow,
  ];

  final List<Genders> _genders = [
    Genders(id: 'woman', name: 'Woman'),
    Genders(id: 'man', name: 'Man'),
    Genders(id: 'non-binary', name: 'Non Binary'),
  ];

  final List<Sexuality> _sexualities = [
    Sexuality(id: 'non-say', name: 'Prefer not to say'),
    Sexuality(id: 'straight', name: 'Straight'),
    Sexuality(id: 'gay', name: 'Gay'),
    Sexuality(id: 'lesbian', name: 'Lesbian'),
    Sexuality(id: 'bisexual', name: 'Bisexual'),
    Sexuality(id: 'trans', name: 'Transgender'),
  ];

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
    );
  }

  Widget _buildPagePhoneNumber(Size size) {
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
                      'assets/imgs/vector_phone_number.png',
                    ),
                  ),
                  Center(
                    child: Image.asset('assets/imgs/phone_number_img.png'),
                  ),
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
                          print(number.phoneNumber);
                        },
                      ),
                    )
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: Color(0xFF686E8C),
                    //         width: 2.0,
                    //       ),
                    //     ),
                    //     border: UnderlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: Color(0xFF686E8C),
                    //         width: 2.0,
                    //       ),
                    //     ),
                    //   ),
                    //   style: const TextStyle(
                    //     color: Color(0xFF686E8C),
                    //     fontSize: 24,
                    //     fontFamily: Strings.fontFamily,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    //   keyboardType: TextInputType.name,
                    // ),
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
    );
  }

  Widget _buildPageCode(Size size) {
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
                  PinCodeTextField(
                    appContext: context,
                    length: 5,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      borderRadius: BorderRadius.circular(50),
                      activeFillColor:
                          Colors.white, // Color de relleno cuando tiene numero
                      disabledColor: Colors.green, // No
                      errorBorderColor: Colors.red.shade200,
                      inactiveColor:
                          AppTheme.disabledColor, // Colors of the lines
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      shape: PinCodeFieldShape.underline,
                      // activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    // controller: textEditingController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      // print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     enabledBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: Color(0xFF686E8C),
                  //         width: 2.0,
                  //       ),
                  //     ),
                  //     border: UnderlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: Color(0xFF686E8C),
                  //         width: 2.0,
                  //       ),
                  //     ),
                  //   ),
                  //   style: const TextStyle(
                  //     color: Color(0xFF686E8C),
                  //     fontSize: 24,
                  //     fontFamily: Strings.fontFamily,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  //   keyboardType: TextInputType.name,
                  // ),

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
          ],
        ),
      ),
    );
  }

  Widget _buildPageEmail(Size size) {
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
                TextFormField(
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
                  keyboardType: TextInputType.emailAddress,
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
                        gender.id != 'non-binary' ? Divider() : Container(),
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

    return SafeArea(
      child: Scaffold(
        body: PageView(
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
            _buildPageCode(size),
            _buildPageEmail(size),
            _buildPagePassword(size),
            _buildPageGender(size),
            _buildPageSexuality(size),
            _buildPageLocation(size),
          ],
        ),
        // floatingActionButton: const CircularProgressIndicator(
        //   backgroundColor: AppTheme.disabledColor,
        //   valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        // )
        floatingActionButton:
            ButtonCircularProgress(pageviewController: pageviewController),
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
  });

  final PageController pageviewController;

  @override
  State<ButtonCircularProgress> createState() => _ButtonCircularProgressState();
}

class _ButtonCircularProgressState extends State<ButtonCircularProgress> {
  double percent = 0.125;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicatorButton(
      onPressed: () {
        widget.pageviewController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        setState(() {
          percent = percent + 0.125;
        });
      },
      percent: percent,
      backgroundColor: percent < 1
          ? AppTheme.disabledColor
          : Color.fromARGB(255, 204, 66, 24),
      // Relleno de color en los bordes basado en la página actual
    );
  }
}
