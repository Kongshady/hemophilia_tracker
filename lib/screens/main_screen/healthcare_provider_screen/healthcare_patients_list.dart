import 'package:flutter/material.dart';

class HealthcarePatientsList extends StatefulWidget {
  const HealthcarePatientsList({super.key});

  @override
  State<HealthcarePatientsList> createState() => _HealthcarePatientsListState();
}

class _HealthcarePatientsListState extends State<HealthcarePatientsList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.redAccent,
          labelColor: Colors.redAccent,
          unselectedLabelColor: Colors.black54,
          tabs: const [
            Tab(text: 'Patients List'),
            Tab(text: 'Incoming Request'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            // Patients List Tab
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Patients List',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return TempList();
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Incoming Request Tab
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Incoming Request',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              'R',
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                          title: Text('Request from Patient ${index + 1}'),
                          subtitle: Text('Wants to share their data with you'),
                          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                          onTap: () {
                            // Handle request tap
                          },
                        );
                      },
                    ),
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

class TempList extends StatefulWidget {
  const TempList({super.key});

  @override
  State<TempList> createState() => _TempListState();
}

class _TempListState extends State<TempList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Text(
          'A',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      title: Text('Patient Name'),
      subtitle: Text('Condition: Hemophilia A'),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: () {
        // Navigate to patient details
      },
    );
  }
}