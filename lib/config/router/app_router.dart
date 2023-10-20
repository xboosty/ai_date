import 'package:flutter/material.dart';

import '../../presentation/screens/screens.dart';

class AppRouter {
  static const String initialRoute = HomeScreen.routeName;

  static Map<String, Widget Function(BuildContext)> appRouter() => {
        SplashScreen.routeName: (_) => const SplashScreen(),
        IntroductionScreen.routeName: (_) => const IntroductionScreen(),
        OnBoardingScreen.routeName: (_) => const OnBoardingScreen(),
        SignInScreen.routeName: (_) => const SignInScreen(),
        ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
        ChangePasswordScreen.routeName: (_) => const ChangePasswordScreen(),
        SuccessChangePasswordScreen.routeName: (_) =>
            const SuccessChangePasswordScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        InterviewChatScreen.routeName: (_) => const InterviewChatScreen(),
      };
}
