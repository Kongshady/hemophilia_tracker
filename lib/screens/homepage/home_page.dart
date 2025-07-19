import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemophilia_manager/auth/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showPreScreeningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          icon: const Icon(
            Icons.question_mark,
            color: Colors.redAccent,
            size: 40,
          ),
          title: const Text(
            'Not sure if you have hemophilia?',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: const Text(
            'Try our quick pre-screening test it will only take a few minutes.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('I already know'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                // TODO: Navigate to screening test page
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Take me to the test'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App name centered
                Text(
                  'BleedWatchPH',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // Main buttons
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomStartingButton(
                            btnTitle: 'Login',
                            bgColor: Colors.redAccent,
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: CustomStartingButton(
                            btnTitle: 'Create Account',
                            bgColor: Colors.redAccent,
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/register');
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign in with Google',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              FontAwesomeIcons.google,
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: CustomStartingButton(
                        btnTitle: 'Continue As Guest',
                        bgColor: const Color.fromARGB(255, 41, 41, 41),
                        onTap: () async {
                          await AuthService().signInAnonymously();
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, '/user_screen');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showPreScreeningDialog,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        icon: Icon(FontAwesomeIcons.clipboardList),
        label: Text('Try Pre-Screening'),
      ),
    );
  }
}

class CustomStartingButton extends StatelessWidget {
  final String btnTitle;
  final Color bgColor;
  final VoidCallback onTap;

  const CustomStartingButton({
    super.key,
    required this.btnTitle,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onTap,
      child: Text(btnTitle),
    );
  }
}
