import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemophilia_manager/widgets/custom_speed_dial.dart';

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
        title: const Text('HemoTrack PH', style: TextStyle(fontWeight: FontWeight.bold),),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            // Greeting for the user
            Column(
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Icon(FontAwesomeIcons.droplet, size: 35, color: Colors.red,),
                    Text('Good Morning, UserName!', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                  ],
                ),

            SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How do you feel today?', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter what you feel today',
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),

              ],
            ),
        
            // How do you feel today?

            // Todays Reminders
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today\'s Reminders', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextButton(onPressed: () {

                }, child: const Text('View All'))
              ],
            ),
        
            // Recent Activities
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Activities', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextButton(onPressed: () {

                }, child: const Text('View All'))
              ],
            ),

          ],
        ),
      ),
      floatingActionButton: CustomSpeedDial(),
      // Custom Speed Dial Widget from widgets/custom_speed_dial.dart
    );
  }
}
