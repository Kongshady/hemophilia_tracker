import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemophilia_manager/screens/main_screen/patient_screens/dashboard_screens.dart/emergency_fab.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          'BleedWatchPH',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidBell),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidUser),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting and quick info
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              Text(
                'Here’s your health summary for today.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 22),

              // Reminders Section
              Text(
                'Reminders',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.syringe,
                  color: Colors.redAccent,
                ),
                title: Text('Infusion Reminder', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: Text('No infusion scheduled today'),
                tileColor: Colors.grey.shade200,
              ),
              SizedBox(height: 5,),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.blueAccent),
                title: Text('Doctor Appointment', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: Text('No appointments today'),
                tileColor: Colors.grey.shade200,
              ),
              SizedBox(height: 28),

              // Recent Activity Section
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.droplet,
                  color: Colors.redAccent,
                ),
                title: Text('Logged Bleed', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: Text('Left knee, 2 days ago'),
                tileColor: Colors.grey.shade200,
              ),
              SizedBox(height: 5,),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.capsules,
                  color: Colors.blueAccent,
                ),
                title: Text('Infusion Taken', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: Text('Factor VIII, 3 days ago'),
                tileColor: Colors.grey.shade200,
              ),
              SizedBox(height: 28),
            ],
          ),
        ),
      ),
      floatingActionButton: EmergencyFab(),
    );
  }
}
