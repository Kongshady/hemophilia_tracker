import 'package:flutter/material.dart';

class ClinicLocatorScreen extends StatefulWidget {
  const ClinicLocatorScreen({super.key});

  @override
  State<ClinicLocatorScreen> createState() => _ClinicLocatorScreenState();
}

class _ClinicLocatorScreenState extends State<ClinicLocatorScreen> {
  final List<Map<String, String>> clinics = [
    {
      'name': 'Ms. Miltordeliza B. Gonzaga, MD',
      'address':
          'Room 601, Davao Doctor’s Hospital, 115 E. Quirino Avenue, Davao City, Davao Del Sur'
    },
    {
      'name': 'Dr. Heide Abdurahman',
      'address':
          'Brokenshire Hospital, Madapo Hills, Poblacion District, Davao City, 8000 Davao Del Sur'
    },
    {
      'name': 'Davao Doctor’s Hospital',
      'address':
          'Room 601, Medical Towers Davao Doctor’s Hospital, 115 E. Quirino Avenue, Davao City, Davao Del Sur'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clinic Locator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Filter action
            },
            child: Text(
              'Filter',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Temporary grey box instead of map
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: Text(
                  'Map Placeholder',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Hospital Lists',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            SizedBox(height: 2),
            Text(
              'Near you',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: clinics.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final clinic = clinics[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      title: Text(
                        clinic['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        clinic['address']!,
                        style: TextStyle(fontSize: 13),
                      ),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // Optionally animate to marker or show details
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
