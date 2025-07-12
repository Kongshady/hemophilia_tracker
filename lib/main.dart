import 'package:flutter/material.dart';
import 'package:hemophilia_manager/routes/routes.dart';
import 'package:hemophilia_manager/screens/onboarding/onboarding_screen.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.redAccent,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.redAccent,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: Colors.black,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.white70),
              titleLarge: TextStyle(color: Colors.white),
              titleMedium: TextStyle(color: Colors.white),
              titleSmall: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          themeMode: currentMode,
          debugShowCheckedModeBanner: false,
          home: OnboardingScreen(),
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
