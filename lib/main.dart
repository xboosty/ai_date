import 'package:flutter/material.dart';

// Configs
import 'config/config.dart' show AppRouter, AppTheme;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
