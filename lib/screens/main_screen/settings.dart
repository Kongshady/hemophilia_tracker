import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../main.dart'; // Import the themeNotifier

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
      body: Padding(
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
                    shape: RoundedRectangleBorder(),
                  ),
                  child: Text('Edit Personal Information'),
                ),
              ],
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  CustomSettingsListTile(
                    tileTitle: 'Notification and Sounds',
                    tileIcon: FontAwesomeIcons.bell,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),
                  SizedBox(height: 5),
                  CustomSettingsListTile(
                    tileTitle: 'Dark Mode',
                    tileIcon: FontAwesomeIcons.paintRoller,
                    iconBg: Colors.grey,
                    trailing: Switch(
                      activeColor: Colors.green,
                      trackOutlineColor: MaterialStateProperty.all(Colors.grey),
                      value: themeNotifier.value == ThemeMode.dark,
                      onChanged: (value) {
                        themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomSettingsListTile(
                    tileTitle: 'Password',
                    tileIcon: FontAwesomeIcons.lock,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),
                  SizedBox(height: 5),
                  CustomSettingsListTile(
                    tileTitle: 'Clear cache',
                    tileIcon: FontAwesomeIcons.brush,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),
                  SizedBox(height: 5),
                  CustomSettingsListTile(
                    tileTitle: 'Terms and Privacy Policy',
                    tileIcon: FontAwesomeIcons.info,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),
                  SizedBox(height: 5),
                  CustomSettingsListTile(
                    tileTitle: 'Delete Account',
                    tileIcon: FontAwesomeIcons.trashCan,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),
                  SizedBox(height: 5),
                  CustomSettingsListTile(
                    tileTitle: 'Logout',
                    tileIcon: FontAwesomeIcons.doorClosed,
                    iconBg: Colors.redAccent,
                    onTap: () {},
                    trailing: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSettingsListTile extends StatelessWidget {
  final String tileTitle;
  final IconData tileIcon;
  final Color iconBg;
  final VoidCallback? onTap;
  final Widget? trailing;

  const CustomSettingsListTile({
    super.key,
    required this.tileTitle,
    required this.tileIcon,
    required this.iconBg,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tileTitle),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      leading: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(tileIcon, color: Colors.white),
      ),
      tileColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      trailing: trailing, // Only shows if not null
      onTap: onTap,
    );
  }
}
