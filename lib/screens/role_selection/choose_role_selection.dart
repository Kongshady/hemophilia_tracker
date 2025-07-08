import 'package:flutter/material.dart';
import 'package:hemophilia_manager/screens/main_screen/main_screen_display.dart';

class ChooseRoleSelection extends StatefulWidget {
  const ChooseRoleSelection({super.key});

  @override
  State<ChooseRoleSelection> createState() => _ChooseRoleSelectionState();
}

class _ChooseRoleSelectionState extends State<ChooseRoleSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Text('Lets get started. What describes you best?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              // Spacer
              SizedBox(height: 20),
        
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreenDisplay()));
                },
                child: Container(
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color.fromARGB(255, 230, 230, 230), width: 2),
                    
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.heart_broken_sharp, size: 55,),
                      SizedBox(height: 10),
                      Text('I am a Patient',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('I have hemophlia and I want to track my own health',
                        style: TextStyle(fontSize: 14,),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // Spacer
              SizedBox(height: 20),
        
              GestureDetector(
                onTap: () {
                  // Navigate to next screen for caregiver
                },
                child: Container(
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color.fromARGB(255, 230, 230, 230), width: 2),
                    
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.heart_broken_sharp, size: 55,),
                      SizedBox(height: 10),
                      Text('I am a Caregiver',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('I care for someone with hemophilia and I want to track their health',
                        style: TextStyle(fontSize: 14,),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // Spacer
              SizedBox(height: 20),
        
              GestureDetector(
                onTap: () {
                  // Navigate to next screen for medical professional
                },
                child: Container(
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color.fromARGB(255, 230, 230, 230), width: 2),
                    
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.heart_broken_sharp, size: 55,),
                      SizedBox(height: 10),
                      Text('I am a Medical Professional',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('I work with patients who have hemophilia and I want to track their health',
                        style: TextStyle(fontSize: 14,),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}