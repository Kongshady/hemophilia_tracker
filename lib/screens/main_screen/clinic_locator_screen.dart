import 'package:flutter/material.dart';

class ClinicLocatorScreen extends StatefulWidget {
  const ClinicLocatorScreen({super.key});

  @override
  State<ClinicLocatorScreen> createState() => _ClinicLocatorScreenState();
}

class _ClinicLocatorScreenState extends State<ClinicLocatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clinic Locator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text
            Text(
              'Treatment Center Near You',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
        
            // Clinic Lists
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Clinic A'),
                    subtitle: const Text('Address: 123 Main St, City, State'),
                    onTap: () {
                      // Navigate to clinic details
                    },
                  ),
                  ListTile(
                    title: const Text('Clinic B'),
                    subtitle: const Text('Address: 456 Elm St, City, State'),
                    onTap: () {
                      // Navigate to clinic details
                    },
                  ),
                  ListTile(
                    title: const Text('Clinic C'),
                    subtitle: const Text('Address: 789 Oak St, City, State'),
                    onTap: () {
                      // Navigate to clinic details
                    },
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
