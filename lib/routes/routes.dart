import 'package:flutter/material.dart';
import 'package:hemophilia_manager/screens/homepage/home_page.dart';
import 'package:hemophilia_manager/screens/main_screen/dashboard_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/dosage_calculator_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/log_bleed.dart';
import 'package:hemophilia_manager/screens/main_screen/main_screen_display.dart';
import 'package:hemophilia_manager/screens/main_screen/notifications_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/schedule_medication_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/settings.dart';
import 'package:hemophilia_manager/screens/onboarding/onboarding_screen.dart';
import 'package:hemophilia_manager/screens/registration/create_acc_page.dart';
import 'package:hemophilia_manager/screens/registration/login_page.dart';
import 'package:hemophilia_manager/screens/role_selection/choose_role_selection.dart';
import 'package:hemophilia_manager/screens/role_selection/user_creation_success.dart';
import 'package:hemophilia_manager/screens/role_selection/user_details.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String homepage = '/homepage';
  static const String login = '/login';
  static const String register = '/register';
  static const String roleSelection = '/role_selection';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String doseCalculator = '/dose_calculator';
  static const String logBleed = '/log_bleed';
  static const String scheduleMedication = '/schedule_medication';
  static const String userFillup = '/user_fillup';
  static const String userAccountCreated = '/user_account_created';
  static const String userScreen = '/user_screen';

  static Map<String, WidgetBuilder>  routes = {
      onboarding: (context) => const OnboardingScreen(),
      homepage: (context) => const HomePage(),
      login: (context) => const LoginPage(),
      register: (context) => const CreateAccPage(),
      roleSelection: (context) => const ChooseRoleSelection(),
      settings: (context) => const UserSettings(),
      notifications: (context) => const NotificationsScreen(),
      doseCalculator: (context) => const DosageCalculatorScreen(),
      logBleed: (context) => const LogBleed(),
      scheduleMedication: (context) => const ScheduleMedicationScreen(),
      userFillup: (context) => const UserDetails(),
      userAccountCreated: (context) => const UserCreationSuccess(),
      userScreen: (context) => const MainScreenDisplay(),
      // Add other routes here as needed
  };
}