import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../../widgets/widgets.dart' show WelcomeText;

class IntroductionScreenFirst extends StatelessWidget {
  const IntroductionScreenFirst({super.key});

  static const String routeName = '/introduction_screen_first';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      width: double.infinity,
      height: size.height,
      color: const Color(0xFF261638),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            right: size.width * (-0.19),
            child: const WelcomeText(fontSize: 80),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.45,
                width: size.width * 0.80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.25,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        gradient: AppTheme.linearGradient,
                      ),
                      child: Image.asset(
                        'assets/imgs/aidate_img_1.png',
                        fit: BoxFit.contain,
                        height: 5,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Let’s begin with some simple questions about you',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF261638),
                            fontSize: 20,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              FilledButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'LET’S START',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: size.width * 0.01),
                    const Icon(Icons.arrow_right_alt)
                  ],
                ),
                onPressed: () {},
              ),
            ],
          ),
          Positioned(
            bottom: 1,
            left: size.width * (-0.17),
            child: const WelcomeText(fontSize: 80),
          )
        ],
      ),
    ));
  }
}
