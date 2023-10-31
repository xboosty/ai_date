import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../../widgets/widgets.dart' show FilledColorizedButton, OutlineText;
import '../screens.dart' show RegisterScreen, RegisterScreenArguments;

class IntroductionScreenArguments {
  final UserCredential? firebaseUserCredential;

  IntroductionScreenArguments(this.firebaseUserCredential);
}

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  static const String routeName = '/introduction_screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments
        as IntroductionScreenArguments?;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.55,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    gradient: AppTheme.linearGradientReverse,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const OutlineText(
                        fontSize: 65,
                        title: 'Welcome!',
                        color: Colors.white,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Image.asset('assets/imgs/aidate_img_1.png')
                    ],
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'Let\'s begin with some simple questions about you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF261638),
                        fontSize: 28,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  FilledColorizedButton(
                    width: size.width * 0.50,
                    height: 50,
                    title: 'LET\'S START',
                    isTrailingIcon: true,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RegisterScreen.routeName,
                        arguments: args != null
                            ? RegisterScreenArguments(
                                args.firebaseUserCredential,
                              )
                            : null,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
