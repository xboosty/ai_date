import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../../widgets/widgets.dart' show FilledColorizedButton, OutlineText;
import '../screens.dart' show OnBoardingScreen;

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  static const String routeName = '/introduction_screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: size.height,
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
                  Container(
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
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const OnBoardingScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideInRight(child: child);
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
