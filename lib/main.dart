import 'package:flutter/material.dart';
import 'package:hemophilia_manager/routes/routes.dart';
import 'package:hemophilia_manager/screens/homepage/home_page.dart';
import 'package:hemophilia_manager/screens/main_screen/patient_screens/log_bleed.dart';
import 'package:hemophilia_manager/screens/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hemophilia_manager/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(BleedLogAdapter());
  await Hive.openBox<BleedLog>('bleed_logs');
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(initialRoute: isLoggedIn ? '/user_screen' : '/homepage'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  Future<bool> _getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_complete') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return FutureBuilder<bool>(
          future: _getOnboardingStatus(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              );
            }
            final onboardingComplete = snapshot.data!;
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
              initialRoute: initialRoute,
              home: onboardingComplete ? HomePage() : OnboardingScreen(),
              routes: AppRoutes.routes,
            );
          },
        );
      },
    );
  }
}
