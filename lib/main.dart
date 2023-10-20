import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Configs
import 'config/config.dart'
    show
        AccountCubit,
        AppRouter,
        AppTheme,
        SharedPref,
        getIt,
        serviceLocatorBlocsInit,
        serviceLocatorNotificationInit,
        serviceLocatorRepositoryInit;

void main() async {
  // Start Widget
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing services locators
  serviceLocatorRepositoryInit();
  serviceLocatorBlocsInit();
  serviceLocatorNotificationInit();

  // Initializing SharedPreferences
  await SharedPref.pref.initPrefer();

  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AccountCubit>(),
        ),
      ],
      child: const AIDateApp(),
    );
  }
}

class AIDateApp extends StatelessWidget {
  const AIDateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Date',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.initialRoute,
      routes: AppRouter.appRouter(),
      theme: AppTheme(isDarkmode: false).getTheme(),
    );
  }
}
