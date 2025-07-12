import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Minimalist app name
                Center(
                  child: Text(
                    'BleedWatch',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: 36),
                Text(
                  'Sign in to your account',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 28),
                // Email field with icon
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.redAccent),
                    labelText: 'Email or Phone Number',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 18),
                // Password field with icon
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.redAccent),
                    labelText: 'Password',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/user_screen');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('or', style: TextStyle(color: Colors.black54)),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.google, color: Colors.redAccent, size: 28),
                      onPressed: () {
                        // Google sign-in
                      },
                      tooltip: 'Sign in with Google',
                    ),
                    SizedBox(width: 18),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.facebookF, color: Colors.blueAccent, size: 28),
                      onPressed: () {
                        // Facebook sign-in
                      },
                      tooltip: 'Sign in with Facebook',
                    ),
                    SizedBox(width: 18),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.apple, color: Colors.black, size: 28),
                      onPressed: () {
                        // Apple sign-in
                      },
                      tooltip: 'Sign in with Apple',
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?', style: TextStyle(color: Colors.black87)),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Register now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
