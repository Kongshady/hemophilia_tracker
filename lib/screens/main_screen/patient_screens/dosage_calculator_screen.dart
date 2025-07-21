import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/firestore.dart';

class DosageCalculatorScreen extends StatefulWidget {
  const DosageCalculatorScreen({super.key});

  @override
  State<DosageCalculatorScreen> createState() => _DosageCalculatorScreenState();
}

class _DosageCalculatorScreenState extends State<DosageCalculatorScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController factorLevelController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  
  String selectedType = 'Hemophilia A';
  String userRole = '';
  String userHemophiliaType = '';
  bool isLoading = true;
  bool canEditHemophiliaType = false;
  double? result;

  final List<String> hemophiliaTypes = [
    'Hemophilia A',
    'Hemophilia B',
    'Hemophilia C',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // TODO: Add loading indicator while fetching user profile
  // TODO: Add error handling for network issues
  // TODO: Cache user profile data to avoid repeated API calls
  Future<void> _loadUserProfile() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final userProfile = await _firestoreService.getUserProfile(uid);
        if (userProfile != null) {
          setState(() {
            userRole = userProfile['role'] ?? '';
            userHemophiliaType = userProfile['hemophiliaType'] ?? 'Hemophilia A';
            selectedType = userHemophiliaType;
            canEditHemophiliaType = userRole == 'caregiver';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // TODO: Show error message to user
      print('Error loading user profile: $e');
    }
  }

  // TODO: Add more sophisticated dosage calculation formulas
  // TODO: Add safety warnings for high dosages
  // TODO: Save calculation history for future reference
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
      dosage = weight * factorLevel * 0.7;
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
        title: Text(
          'Dosage Calculator',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement calculation history feature
            },
            icon: Icon(FontAwesomeIcons.clockRotateLeft),
          ),
        ],
      ),
      // TODO: Ask if history is needed
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Here\'s your recommended dosage:'),
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
                              'Press Calculate to get the result.',
                              style: TextStyle(color: Colors.black54),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${result!.toStringAsFixed(2)} IU',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'For $selectedType',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(height: 20),
                    
                    // Weight and Target Factor Level in a row
                    Row(
                      children: [
                        // Weight input (left side)
                        Expanded(
                          child: TextField(
                            controller: weightController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.monitor_weight_outlined,
                                color: Colors.green,
                              ),
                              labelText: 'Weight (kg)',
                              helperText: 'Weight in kilograms',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        // Target Factor Level input (right side)
                        Expanded(
                          child: TextField(
                            controller: factorLevelController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.percent, color: Colors.green),
                              labelText: 'Factor Level',
                              border: UnderlineInputBorder(),
                              helperText: 'Range: 1-100%',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    
                    // Hemophilia Type dropdown underneath the row
                    canEditHemophiliaType
                        ? DropdownButtonFormField<String>(
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
                              prefixIcon: Icon(Icons.bloodtype, color: Colors.green),
                              labelText: 'Hemophilia Type',
                              border: UnderlineInputBorder(),
                            ),
                          )
                        : TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.bloodtype, color: Colors.grey),
                              labelText: 'Hemophilia Type (Locked)',
                              hintText: selectedType,
                              border: UnderlineInputBorder(),
                              suffixIcon: Tooltip(
                                message: 'Your hemophilia type is locked. Only caregivers can modify this.',
                                child: Icon(Icons.lock, color: Colors.grey, size: 20),
                              ),
                            ),
                          ),
                    SizedBox(height: 28),
                    
                    // Calculate button under the dropdown
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: calculateDosage,
                        icon: const Icon(
                          FontAwesomeIcons.calculator,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Calculate',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    
                    // Info banner for locked hemophilia type
                    if (!canEditHemophiliaType) ...[
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Hemophilia type is set based on your profile and cannot be changed.',
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}
