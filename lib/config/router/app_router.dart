import 'package:flutter/material.dart';

import '../../presentation/screens/screens.dart';

class AppRouter {
  static const String initialRoute = SplashScreen.routeName;

  static Map<String, Widget Function(BuildContext)> appRouter() => {
        SplashScreen.routeName: (_) => const SplashScreen(),
        IntroductionScreen.routeName: (_) => const IntroductionScreen(),
        OnBoardingScreen.routeName: (_) => const OnBoardingScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        SignInScreen.routeName: (_) => const SignInScreen(),
        ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
        SuccessChangePasswordScreen.routeName: (_) =>
            const SuccessChangePasswordScreen(),
      };
}
