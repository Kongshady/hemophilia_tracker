import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EducationalResources extends StatefulWidget {
  const EducationalResources({super.key});

  @override
  State<EducationalResources> createState() => _EducationalResourcesState();
}

class _EducationalResourcesState extends State<EducationalResources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Resources', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(FontAwesomeIcons.book, color: Colors.red),
              title: Text('Understanding Hemophilia'),
              subtitle: Text('12 Topics'),
              onTap: () {
                // Navigate to the resource details
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.capsules, color: Colors.red),
              title: Text('Treatment Options'),
              subtitle: Text('8 Topics'),
              onTap: () {
                // Navigate to the resource details
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.weightScale, color: Colors.red),
              title: Text('Living with Hemophilia'),
              subtitle: Text('5 Topics'),
              onTap: () {
                // Navigate to the resource details
              },
            ),
            ListTile(
              leading: Icon(Icons.article, color: Colors.red),
              title: Text('Family and Caregiver Support'),
              subtitle: Text('10 Topics'),
              onTap: () {
                // Navigate to the resource details
              },
            ),
          ],
        ),
      ),
    );
  }
}