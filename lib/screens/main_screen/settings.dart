import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemophilia_manager/widgets/custom_settings_tile.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              // User Image with name and email address with edit button under it
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      // Image Placeholder
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey,
                        ),
                        padding: EdgeInsets.all(40),
                      ),
        
                      // Name and email Add
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name Placeholder',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text('username@gmail.com'),
                        ],
                      ),
                    ],
                  ),
        
                  SizedBox(height: 5),
        
                  FilledButton(
                    onPressed: () {
                      // Action
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder()
                    ),
                    child: Text('Edit Profile'),
                  ),
                ],
              ),
        
              SizedBox(height: 20),
        
              // Preferences. Notification and sounds and Theme
              Text('Preferences'),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(80, 158, 158, 158),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    CustomSettingsListTile(
                      tileTitle: 'Notification and Sounds',
                      tileIcon: FontAwesomeIcons.bell,
                      iconBg: Colors.grey,
                    ),
        
                    Divider(thickness: 1, color: Colors.white),
        
                    CustomSettingsListTile(
                      tileTitle: 'Theme',
                      tileIcon: FontAwesomeIcons.paintRoller,
                      iconBg: Colors.grey,
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 20),
        
              // Account. Password, Clear Cache, Terms and Privacy Policy, Delete Account, LogOut
              Text('Account'),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(80, 158, 158, 158),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    CustomSettingsListTile(
                      tileTitle: 'Password',
                      tileIcon: FontAwesomeIcons.lock,
                      iconBg: Colors.grey,
                    ),
        
                    Divider(thickness: 1, color: Colors.white),
        
                    CustomSettingsListTile(
                      tileTitle: 'Clear cache',
                      tileIcon: FontAwesomeIcons.brush,
                      iconBg: Colors.grey,
                    ),
        
                    Divider(thickness: 1, color: Colors.white),
        
                    CustomSettingsListTile(
                      tileTitle: 'Terms and Privacy Policy',
                      tileIcon: FontAwesomeIcons.info,
                      iconBg: Colors.grey,
                    ),
        
                    Divider(thickness: 1, color: Colors.white),
        
                    CustomSettingsListTile(
                      tileTitle: 'Delete Account',
                      tileIcon: FontAwesomeIcons.trashCan,
                      iconBg: Colors.grey,
                    ),
        
                    Divider(thickness: 1, color: Colors.white),
        
                    CustomSettingsListTile(
                      tileTitle: 'Logout',
                      tileIcon: FontAwesomeIcons.doorClosed,
                      iconBg: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
