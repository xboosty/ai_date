import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../screens.dart' show SignInScreen;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigationHome();
  }

  void _navigationHome() async {
    await Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          gradient: AppTheme.radialGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Strings.imageLogo),
              const SizedBox(height: 5.0),
              AspectRatio(
                aspectRatio: 16 / 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 10),
                  child: Text(
                    'Your Perfect Match Awaits',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..shader = AppTheme.linearGradientShader,
                      fontFamily: Strings.fontFamily,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              const Text(
                'AI-Enhanced Precision',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                  height: 0.06,
                ),
              ),
              const Spacer(),
              Container(
                // color: Colors.red,
                width: double.infinity,
                height: size.height * 0.55,
                child: Image.asset(
                  'assets/imgs/splash_1.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
