import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:hemophilia_manager/screens/main_screen/patient_screens/chatbot_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/patient_screens/clinic_locator_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/patient_screens/dashboard_screens.dart/dashboard_screen.dart';
import 'package:hemophilia_manager/screens/main_screen/patient_screens/educ_resources/educational_resources_screen.dart';

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
    EducationalResourcesScreen(),
    ChatbotScreen(),
    ClinicLocatorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Image.asset('assets/images/app_logo.png', width: 60),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.redAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              // ignore: deprecated_member_use
              backgroundColor: Colors.redAccent.withOpacity(0.15),
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.solidBell, color: Colors.redAccent),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                child: Icon(Icons.person, color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 600,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                            // physics: NeverScrollableScrollPhysics(), Temporary disabled
                            children: [
                              _ActionTile(
                                label: 'Log New Bleed',
                                icon: FontAwesomeIcons.droplet,
                                bgColor: Colors.red,
                                onTap: () {
                                  Navigator.pushNamed(context, '/log_bleed');
                                },
                              ),
                              _ActionTile(
                                label: 'Log New Infusion',
                                icon: FontAwesomeIcons.syringe,
                                bgColor: Colors.purple,
                                onTap: () {
                                  Navigator.pushNamed(context, '/log_infusion');
                                },
                              ),
                              _ActionTile(
                                label: 'Schedule Medication',
                                icon: FontAwesomeIcons.pills,
                                bgColor: Colors.blue,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/schedule_medication',
                                  );
                                },
                              ),
                              _ActionTile(
                                label: 'Dosage Calculator',
                                icon: FontAwesomeIcons.calculator,
                                bgColor: Colors.green,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/dose_calculator',
                                  );
                                },
                              ),
                              _ActionTile(
                                label: 'Log History',
                                icon: FontAwesomeIcons.clockRotateLeft,
                                bgColor: Colors.amber,
                                onTap: () {
                                  Navigator.pushNamed(context, '/log_history');
                                },
                              ),
                              _ActionTile(
                                label: 'Add Care Provider',
                                icon: FontAwesomeIcons.plus,
                                bgColor: Colors.redAccent,
                                onTap: () {
                                  Navigator.pushNamed(context, '/care_provider');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
        backgroundColor: Colors.white,
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
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 40, 40, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}