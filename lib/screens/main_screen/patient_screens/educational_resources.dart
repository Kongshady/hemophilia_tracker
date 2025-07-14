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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Educational Resources',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.redAccent),
                  ),
                  Text('Free Resources'),
                ],
              ),

              // TODO: Add a search bar here if needed
        
              SizedBox(height: 15),
        
              Expanded(
                child: ListView(
                  children: [
                    ActionList(
                      listTitle: 'Understanding Hemophilia',
                      listIcon: FontAwesomeIcons.book,
                      listIconColor: Colors.green,
                      listSubtitle: '12 Topics',
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    ActionList(
                      listTitle: 'Treatment Options',
                      listIcon: FontAwesomeIcons.pills,
                      listIconColor: Colors.redAccent,
                      listSubtitle: '8 Topics',
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    ActionList(
                      listTitle: 'Living with Hemophilia',
                      listIcon: FontAwesomeIcons.weightScale,
                      listIconColor: Colors.blueAccent,
                      listSubtitle: '15 Topics',
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    ActionList(
                      listTitle: 'Family and Caregivers',
                      listIcon: FontAwesomeIcons.peopleGroup,
                      listIconColor: Colors.yellow,
                      listSubtitle: '10 Topics',
                      onTap: () {},
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

class ActionList extends StatelessWidget {
  final String listTitle;
  final String listSubtitle;
  final IconData listIcon;
  final Color listIconColor;
  final VoidCallback onTap;

  const ActionList({
    super.key,
    required this.listTitle,
    required this.listIcon,
    required this.listSubtitle,
    required this.onTap,
    required this.listIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(listIcon, color: listIconColor),
      title: Text(listTitle, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(listSubtitle),
      onTap: onTap,
      // ignore: deprecated_member_use
      tileColor: listIconColor.withOpacity(0.15),
    );
  }
}
