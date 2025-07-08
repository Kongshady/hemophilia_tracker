import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DosageCalculatorScreen extends StatefulWidget {
  const DosageCalculatorScreen({super.key});

  @override
  State<DosageCalculatorScreen> createState() => _DosageCalculatorScreenState();
}

class _DosageCalculatorScreenState extends State<DosageCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // ShowModal Will Be Shown Here
            },
            icon: Icon(FontAwesomeIcons.clockRotateLeft),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Calculate your Dosage',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
        
                  SizedBox(height: 20),
        
                  Text('Weight'),
                  SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Pounds',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
        
                  SizedBox(height: 20),
        
                  Text('Hemophilia Type'),
                  SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      labelText:
                          'Choices', // Or Auto Input since there is a medical history
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
        
                  SizedBox(height: 20),
        
                  Text('Target Factor Level'),
                  SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Pounds',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
        
                  SizedBox(height: 20),
        
                  Text(
                    'Result',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
        
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(),
                  ),
                  
                  
                  onPressed: () {
                    // Actions
                  },
                  child: Text('Calculate', style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
