import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Almost There!'),
                Text(
                  'What is your Name?',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
                SizedBox(height: 25),
                UserTextfield(labelTitle: 'Name'),
                SizedBox(height: 15),
                UserTextfield(labelTitle: 'Last name'),
                SizedBox(height: 15),
                // terms and policy here
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/user_account_created');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
                      padding: EdgeInsets.all(13)
                    ),
                    child: Text('Create Account'),
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

class UserTextfield extends StatefulWidget {
  final String labelTitle;

  const UserTextfield({super.key, required this.labelTitle});

  @override
  State<UserTextfield> createState() => _UserTextfieldState();
}

class _UserTextfieldState extends State<UserTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.labelTitle,
        floatingLabelStyle: TextStyle(
          color: const Color.fromARGB(255, 0, 140, 255),
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 0, 140, 255),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
