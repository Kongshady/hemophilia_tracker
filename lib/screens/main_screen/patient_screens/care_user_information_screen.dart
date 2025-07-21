import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CareUserInformationScreen extends StatefulWidget {
  const CareUserInformationScreen({super.key});

  @override
  State<CareUserInformationScreen> createState() =>
      _CareUserInformationScreenState();
}

class _CareUserInformationScreenState extends State<CareUserInformationScreen> {
  bool _shareData = false;

  @override
  Widget build(BuildContext context) {
    final provider = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Provider Information',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.redAccent,
              child: Icon(
                Icons.local_hospital,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              provider?['name'] ?? 'Unknown Provider',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              provider?['email'] ?? 'No email provided',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              'Healthcare Professional',
              style: TextStyle(
                fontSize: 14,
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.share, color: Colors.redAccent),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Share My Data',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'with ${provider?['name'] ?? 'this provider'}',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _shareData,
                              onChanged: (value) {
                                setState(() => _shareData = value);
                                // TODO: Implement data sharing logic
                              },
                              activeColor: Colors.redAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: Colors.redAccent),
                    title: Text(
                      'How does sharing my data work?',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(FontAwesomeIcons.angleRight, color: Colors.redAccent),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Data Sharing Information'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('When you share your data:'),
                              SizedBox(height: 8),
                              Text('• Your bleed logs will be visible to this provider'),
                              Text('• Your medication history will be shared'),
                              Text('• Your dosage calculations will be accessible'),
                              Text('• You can revoke access at any time'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Got it'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(color: Colors.grey.shade300),
                  ListTile(
                    leading: Icon(Icons.email_outlined, color: Colors.redAccent),
                    title: Text(
                      'Contact Provider',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(provider?['email'] ?? 'No email available'),
                    trailing: Icon(FontAwesomeIcons.angleRight, color: Colors.redAccent),
                    onTap: () {
                      // TODO: Implement email functionality
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
