import 'package:flutter/material.dart';
import 'package:hemophilia_manager/routes/routes.dart';
import 'package:hemophilia_manager/widgets/custom_textfield.dart';

class CreateAccPage extends StatefulWidget {
  const CreateAccPage({super.key});

  @override
  State<CreateAccPage> createState() => _CreateAccPageState();
}

class _CreateAccPageState extends State<CreateAccPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lets Register an Account',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 40),

                CustomTextfield(labelTitle: 'Full Name'),

                SizedBox(height: 14),

                CustomTextfield(labelTitle: 'Phone Number'),

                SizedBox(height: 14),

                CustomTextfield(labelTitle: 'Password'),

                SizedBox(height: 14),

                CustomTextfield(labelTitle: 'Confirm Password'),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context,  AppRoutes.roleSelection);
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

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
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
        ),
      ),
    );
  }
}
