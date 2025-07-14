import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CareUserInformationScreen extends StatefulWidget {
  const CareUserInformationScreen({super.key});

  @override
  State<CareUserInformationScreen> createState() =>
      _CareUserInformationScreenState();
}

class _CareUserInformationScreenState extends State<CareUserInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Care User Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/user_profile.png',
              ), // Placeholder image
            ),
            SizedBox(height: 8),
            Text(
              'John Cena, Doctor',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'A brief description about the user goes here.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Share My Data', style: TextStyle(fontWeight: FontWeight.w500),),
                    subtitle: Text('with name of the care provider'),
                    trailing: Switch(
                      value: true, // Example value
                      onChanged: (value) {
                        // Handle switch change
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  ListTile(
                    title: Text('How does sharing my data work?', style: TextStyle(fontWeight: FontWeight.w500),),
                    trailing: Icon(FontAwesomeIcons.angleRight)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
