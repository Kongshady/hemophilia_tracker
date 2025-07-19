import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemophilia_manager/auth/auth.dart';
import 'package:hemophilia_manager/services/firestore.dart';
import '../../../../../main.dart'; // Import the themeNotifier

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  String? _name;
  String? _email;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = AuthService().currentUser;
    if (user != null) {
      setState(() {
        _email = user.email;
        _photoUrl = user.photoURL;
      });
      // Get extra info from Firestore using the public method
      final userData = await FirestoreService().getUser(user.uid);
      if (userData != null) {
        setState(() {
          _name = userData['name'] ?? '';
        });
      }
    }
  }

  void _logout() async {
    await AuthService().signOut();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have been logged out.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      Navigator.pushReplacementNamed(context, '/homepage');
    }
  }

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
                  children: [
                    // User Image
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey,
                      ),
                      width: 80,
                      height: 80,
                      child: ClipOval(
                        child: _photoUrl != null
                          ? Image.network(_photoUrl!, fit: BoxFit.cover)
                          : Icon(Icons.person, size: 48, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 16),
                    // Name and email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name ?? 'Loading...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(_email ?? 'Loading...'),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 5),

                FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/user_info_settings');
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
                    tileTitle: 'Language',
                    tileIcon: FontAwesomeIcons.language,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),
                  CustomSettingsListTile(
                    tileTitle: 'Password',
                    tileIcon: FontAwesomeIcons.lock,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),
                  CustomSettingsListTile(
                    tileTitle: 'Notification and Sounds',
                    tileIcon: FontAwesomeIcons.bell,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),
                  SizedBox(height: 10),
                  Divider(height: 1, color: Colors.grey.shade300),
                  SizedBox(height: 10),
                  CustomSettingsListTile(
                    tileTitle: 'Dark Mode',
                    tileIcon: FontAwesomeIcons.paintRoller,
                    iconBg: Colors.grey,
                    trailing: Switch(
                      activeColor: Colors.green,
                      trackOutlineColor: WidgetStateProperty.all(Colors.grey),
                      value: themeNotifier.value == ThemeMode.dark,
                      onChanged: (value) {
                        themeNotifier.value = value
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      },
                    ),
                  ),

                  CustomSettingsListTile(
                    tileTitle: 'About Us',
                    tileIcon: FontAwesomeIcons.info,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),

                  CustomSettingsListTile(
                    tileTitle: 'Clear cache',
                    tileIcon: FontAwesomeIcons.brush,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),

                  CustomSettingsListTile(
                    tileTitle: 'Terms and Privacy Policy',
                    tileIcon: FontAwesomeIcons.info,
                    iconBg: Colors.grey,
                    onTap: () {},
                    trailing: null,
                  ),

                  CustomSettingsListTile(
                    tileTitle: 'Delete Account',
                    tileIcon: FontAwesomeIcons.trashCan,
                    textColor: Colors.red,
                    iconBg: Colors.red,
                    onTap: () {},
                    trailing: null,
                  ),

                  SizedBox(height: 10),
                  Divider(height: 1, color: Colors.grey.shade300),
                  SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: _logout,
                    icon: Icon(Icons.door_back_door),
                    label: Text('Logout'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blueGrey,
                      iconSize: 30,
                      textStyle: TextStyle(fontSize: 20),
                    ),
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
  final Color? textColor;

  const CustomSettingsListTile({
    super.key,
    required this.tileTitle,
    required this.tileIcon,
    required this.iconBg,
    this.onTap,
    this.trailing,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tileTitle, style: TextStyle(color: textColor)),
      leading: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(tileIcon, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
