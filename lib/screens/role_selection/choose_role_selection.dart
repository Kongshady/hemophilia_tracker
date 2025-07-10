import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChooseRoleSelection extends StatefulWidget {
  const ChooseRoleSelection({super.key});

  @override
  State<ChooseRoleSelection> createState() => _ChooseRoleSelectionState();
}

class _ChooseRoleSelectionState extends State<ChooseRoleSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nice!!'),
                  Text(
                    'Lets get started. What type of account do want to?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              SizedBox(height: 25),

              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    AccountList(
                      listIcon: FontAwesomeIcons.person,
                      listTitle: 'Im a Patient',
                      listSubtitle:
                          'I have hemophilia and I want to track my own health',
                      onTap: () {
                        Navigator.pushNamed(context, '/user_fillup');
                      },
                    ),
                    SizedBox(height: 20),
                    AccountList(
                      listIcon: FontAwesomeIcons.personBreastfeeding,
                      listTitle: 'Im a Caregiver',
                      listSubtitle:
                          'I care for someone with hemophilia and I want to track their health',
                      onTap: () {
                        // Navigations
                      },
                    ),
                    SizedBox(height: 20),
                    AccountList(
                      listIcon: FontAwesomeIcons.userDoctor,
                      listTitle: 'Im a Medical Profesional',
                      listSubtitle:
                          'I work with patients who have hemophilia and I want to track their health',
                      onTap: () {
                        // Navigations
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountList extends StatelessWidget {
  final String listTitle;
  final String listSubtitle;
  final IconData listIcon;
  final VoidCallback onTap;

  const AccountList({
    super.key,
    required this.listTitle,
    required this.listIcon,
    required this.listSubtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      horizontalTitleGap: 20,
      leading: Icon(listIcon, size: 50, color: Colors.white),
      title: Text(
        listTitle,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
      ),
      subtitle: Text(listSubtitle),
      tileColor: const Color.fromARGB(155, 158, 158, 158),
      onTap: onTap,
    );
  }
}


// TODO: Change to apprpriate Colors