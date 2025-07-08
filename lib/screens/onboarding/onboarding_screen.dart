import 'package:flutter/material.dart';
import 'package:hemophilia_manager/screens/onboarding/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      int next = _controller.page?.round() ?? 0;
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < 5) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Replace '/yourNextPage' with your actual route
      Navigator.pushReplacementNamed(context, '/homepage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: [
                OnboardingPage1(
                  textTitle: 'Welcome to HemoTrackPH',
                  textSubTitle:
                      'Your all-in-one solution for managing hemophilia care.',
                  imagePath: 'assets/images/Onboard_img_calculator.jpg',
                ),
                OnboardingPage1(
                  textTitle: 'Easy Health Tracking',
                  textSubTitle:
                      'Log bleeding episodes and medications with just a few steps',
                  imagePath: 'assets/images/Onboard_img_healthTrack.jpg',
                ),
                OnboardingPage1(
                  textTitle: 'Smart Dosage Calculator',
                  textSubTitle:
                      'Get Accurate clotthing factor calculations based on your weight and conditions',
                  imagePath: 'assets/images/Onboard_img_calculator.jpg',
                ),
                OnboardingPage1(
                  textTitle: 'Treatment Reminders',
                  textSubTitle:
                      'Never miss a dose with smart, customizable reminders.',
                  imagePath: 'assets/images/Onboard_img_reminder.jpg',
                ),
                OnboardingPage1(
                  textTitle: 'Locate Healthcare Providers',
                  textSubTitle: 'Find the best healthcare providers near you.',
                  imagePath: 'assets/images/Onboard_img_calculator.jpg',
                ),
                OnboardingPage1(
                  textTitle: 'Learn & Connect',
                  textSubTitle:
                      'Connect with others and learn more about hemophilia.',
                  imagePath: 'assets/images/Onboard_img_calculator.jpg',
                ),
              ],
            ),
            // Bottom-aligned indicator and button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothPageIndicator(
                      effect: ExpandingDotsEffect(
                        dotColor: const Color.fromARGB(255, 199, 199, 199),
                        activeDotColor: Colors.red,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 8.0,
                      ),
                      controller: _controller,
                      count: 6,
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _goToNextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        
                      ),
                      child: Text(
                        _currentPage == 5 ? "Get Started" : "Next",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
