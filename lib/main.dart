import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// Configs
import 'config/config.dart'
    show
        AccountCubit,
        AppRouter,
        AppTheme,
        BlockCubit,
        SharedPref,
        getIt,
        serviceLocatorBlocsInit,
        serviceLocatorNotificationInit,
        serviceLocatorRepositoryInit;

void main() async {
  // Start Widget
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initializing services locators
  serviceLocatorRepositoryInit();
  serviceLocatorBlocsInit();
  serviceLocatorNotificationInit();

  // Initializing SharedPreferences
  await SharedPref.pref.initPrefer();

  FlutterNativeSplash.remove();

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
        BlocProvider(
          create: (context) => getIt<BlockCubit>(),
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
