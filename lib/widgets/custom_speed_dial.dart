import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSpeedDial extends StatefulWidget {
  const CustomSpeedDial({super.key});

  @override
  State<CustomSpeedDial> createState() => _CustomSpeedDialState();
}

class _CustomSpeedDialState extends State<CustomSpeedDial> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
        tooltip: 'Quick Actions',
        spacing: 10,
        animatedIcon: AnimatedIcons.add_event,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        overlayColor: Colors.black,
        overlayOpacity: 0.2,
        buttonSize: Size(70, 70),
        childrenButtonSize: Size(70, 70),
        children: [
          // Temporary Emergency button, might be replaced with a call button
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.phoneFlip),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Emergency',
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Navigator.pushNamed(context, '/addAppointment');
            },
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.clockRotateLeft),
            foregroundColor: Colors.white,
            backgroundColor: Colors.amber,
            label: 'Log History',
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Navigator.pushNamed(context, '/addNote');
            },
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.calculator),
            foregroundColor: Colors.white,
            backgroundColor: Colors.greenAccent,
            label: 'Dosage Calculator',
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Navigator.pushNamed(context, '/dose_calculator');
            },
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.capsules),
            foregroundColor: Colors.white,
            backgroundColor: Colors.lightBlue,
            label: 'Schedule Medication',
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Navigator.pushNamed(context, '/addNote');
            },
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.droplet),
            foregroundColor: Colors.white,
            backgroundColor: Colors.redAccent,
            label: 'Log Bleeding',
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Navigator.pushNamed(context, '/log_bleed');
            },
          ),
        ],
      );
  }
}