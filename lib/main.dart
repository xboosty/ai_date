import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Configs
import 'config/config.dart'
    show
        AccountCubit,
        AppRouter,
        AppTheme,
        getIt,
        serviceLocatorBlocsInit,
        serviceLocatorNotificationInit,
        serviceLocatorRepositoryInit;

void main() async {
  serviceLocatorRepositoryInit();
  serviceLocatorBlocsInit();
  serviceLocatorNotificationInit();

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
        )
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
