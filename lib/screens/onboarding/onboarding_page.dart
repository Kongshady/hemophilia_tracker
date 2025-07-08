import 'package:flutter/material.dart';

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({
    super.key,
    required this.textTitle,
    required this.textSubTitle, required this.imagePath,
  });

  final String textTitle;
  final String textSubTitle;
  final String imagePath;

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Image.asset(
              widget.imagePath,
            ),

            SizedBox(height: 16),

            // Welcome Text
            Text(
              widget.textTitle,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16),

            // Description Text
            Text(
              widget.textSubTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
