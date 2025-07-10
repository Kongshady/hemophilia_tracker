import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Let\'s get started!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // Screening Button
              SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CustomStartingButton(
                      btnTitle: 'Start Screening',
                      bgColor: Colors.green,
                      onTap: () {
                        // TODO: Add screening logic here
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  Text('Or'),

                  // Sign In and Register Buttons
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomStartingButton(
                          btnTitle: 'Login',
                          bgColor: Colors.redAccent,
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: CustomStartingButton(btnTitle: 'Create Account', bgColor: Colors.redAccent, onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },)
                      ),
                    ],
                  ),

                  // Continue As Guest Button
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
                    child: CustomStartingButton(btnTitle: 'Continue As Guest', bgColor: const Color.fromARGB(255, 41, 41, 41), onTap: () {
                      // navigator
                    },)
                  ),
                ],
              ),
            ],
          ),
        ),
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
