import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemophilia_manager/routes/routes.dart';
import 'package:hemophilia_manager/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lets Sign you in',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 40),

            CustomTextfield(labelTitle: 'Email or Phone Number'),

            SizedBox(height: 14),

            CustomTextfield(labelTitle: 'Password'),

            SizedBox(height: 5),

            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Directly Goes to UserDashboard
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),

            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: const Color.fromARGB(141, 158, 158, 158),
                    thickness: 1.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Or'),
                ),
                Expanded(
                  child: Divider(
                    color: const Color.fromARGB(141, 158, 158, 158),
                    thickness: 1.0,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.google, color: Colors.green, size: 40),
                  onPressed: () {
                    // Handle email sign-in
                  },
                ),
                SizedBox(width: 7),
                IconButton(
                  icon: Icon(Icons.facebook, color: Colors.blue, size: 40),
                  onPressed: () {
                    // Handle Facebook sign-in
                  },
                ),
                SizedBox(width: 7),
                IconButton(
                  icon: Icon(Icons.apple, color: Colors.black, size: 40),
                  onPressed: () {
                    // Handle Apple sign-in
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account?'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
