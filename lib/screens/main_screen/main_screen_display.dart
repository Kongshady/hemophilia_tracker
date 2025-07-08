import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:hemophilia_manager/screens/main_screen/chatbot_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/clinic_locator_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/dashboard_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/educational_resources.dart';

class MainScreenDisplay extends StatefulWidget {
  const MainScreenDisplay({super.key});

  @override
  State<MainScreenDisplay> createState() => _MainScreenDisplayState();
}

class _MainScreenDisplayState extends State<MainScreenDisplay> {
  int _currentIndex = 0;

  // BOTTOM NAVIGATION BAR ICONS
  final iconList = <IconData>[
    FontAwesomeIcons.house,
    FontAwesomeIcons.book,
    FontAwesomeIcons.robot,
    FontAwesomeIcons.houseChimneyMedical,
  ];

  // LIST OF DISPLAYED SCREENS
  final List<Widget> _screens = [
    Dashboard(),
    EducationalResources(),
    ChatbotScreen(),
    ClinicLocatorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 450,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Back button row
                      Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.1,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            _ActionTile(
                              label: 'Log Bleeding',
                              icon: FontAwesomeIcons.droplet,
                              bgColor: Colors.red,
                              onTap: () {
                                Navigator.pushNamed(context, '/log_bleed');
                              },
                            ),
                            _ActionTile(
                              label: 'Schedule Medication',
                              icon: FontAwesomeIcons.pills,
                              bgColor: Colors.blue,
                              onTap: () {
                                Navigator.pushNamed(context, '/dose_calculator');
                              },
                            ),
                            _ActionTile(
                              label: 'Dosage Calculator',
                              icon: FontAwesomeIcons.calculator,
                              bgColor: Colors.green,
                              onTap: () {
                                Navigator.pushNamed(context, '/dose_calculator');
                              },
                            ),
                            _ActionTile(
                              label: 'Log History',
                              icon: FontAwesomeIcons.clockRotateLeft,
                              bgColor: Colors.amber,
                              onTap: () {
                                Navigator.pushNamed(context, '/log_bleed');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.redAccent,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        height: 60,
        leftCornerRadius: 16,
        rightCornerRadius: 16,
        activeColor: Colors.redAccent,
        inactiveColor: Colors.blueGrey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Helper widget for grid tiles
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color bgColor;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: bgColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 40, 40, 40)),
            ),
          ],
        ),
      ),
    );
  }
}
