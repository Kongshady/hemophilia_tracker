import 'package:flutter/material.dart';
import 'package:hemophilia_manager/routes/routes.dart';
import 'package:hemophilia_manager/screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
      routes: AppRoutes.routes,
    );
  }
}
