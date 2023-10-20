import 'package:flutter/material.dart';

import '../../presentation/screens/screens.dart';

class AppRouter {
  static const String initialRoute = SplashScreen.routeName;

  static Map<String, Widget Function(BuildContext)> appRouter() => {
        SplashScreen.routeName: (_) => const SplashScreen(),
        IntroductionScreen.routeName: (_) => const IntroductionScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        SignInScreen.routeName: (_) => const SignInScreen(),
        ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
        ChangePasswordScreen.routeName: (_) => const ChangePasswordScreen(),
        SuccessChangePasswordScreen.routeName: (_) =>
            const SuccessChangePasswordScreen(),
        BloquedListScreen.routeName: (_) => const BloquedListScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        InterviewChatScreen.routeName: (_) => const InterviewChatScreen(),
      };
}
