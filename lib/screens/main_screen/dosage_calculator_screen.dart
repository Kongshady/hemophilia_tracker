import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DosageCalculatorScreen extends StatefulWidget {
  const DosageCalculatorScreen({super.key});

  @override
  State<DosageCalculatorScreen> createState() => _DosageCalculatorScreenState();
}

class _DosageCalculatorScreenState extends State<DosageCalculatorScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController factorLevelController = TextEditingController();
  String selectedType = 'Hemophilia A';
  double? result;

  final List<String> hemophiliaTypes = [
    'Hemophilia A',
    'Hemophilia B',
    'Hemophilia C',
  ];

  void calculateDosage() {
    final weight = double.tryParse(weightController.text);
    final factorLevel = double.tryParse(factorLevelController.text);

    if (weight == null || factorLevel == null) {
      setState(() {
        result = null;
      });
      return;
    }

    // Example calculation (replace with actual formula as needed)
    double dosage;
    if (selectedType == 'Hemophilia A') {
      dosage = weight * factorLevel * 0.5;
    } else if (selectedType == 'Hemophilia B') {
      dosage = weight * factorLevel * 1.0;
    } else if (selectedType == 'Hemophilia C') {
      dosage =
          weight * factorLevel * 0.7; // Example coefficient for Hemophilia C
    } else {
      dosage = 0.0;
    }

    setState(() {
      result = dosage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // Show history modal or similar
            },
            icon: Icon(FontAwesomeIcons.clockRotateLeft),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calculate your Dosage',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 28),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.monitor_weight_outlined,
                    color: Colors.redAccent,
                  ),
                  labelText: 'Weight (kg)',
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 18),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: hemophiliaTypes
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedType = val);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.bloodtype, color: Colors.redAccent),
                  labelText: 'Hemophilia Type',
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 18),
              TextField(
                controller: factorLevelController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.percent, color: Colors.redAccent),
                  labelText: 'Target Factor Level (%)',
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: calculateDosage,
                  child: Text(
                    'Calculate',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Result',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text('Recommended Dosage'),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: result == null
                    ? Text(
                        'Enter all fields and press Calculate.',
                        style: TextStyle(color: Colors.black54),
                      )
                    : Text(
                        '${result!.toStringAsFixed(2)} IU',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.redAccent,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
