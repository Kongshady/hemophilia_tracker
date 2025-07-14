import 'package:flutter/material.dart';

class LogHistoryScreen extends StatefulWidget {
  const LogHistoryScreen({super.key});

  @override
  State<LogHistoryScreen> createState() => _LogHistoryScreenState();
}

class _LogHistoryScreenState extends State<LogHistoryScreen>
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
        title: const Text(
          'Log History',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.redAccent,
          labelColor: Colors.redAccent,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          tabs: const [
            Tab(text: 'Bleeding Episodes'),
            Tab(text: 'Infusion Taken'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SampleScreen(screenTitle: 'Bleeding Episodes'),
          SampleScreen(screenTitle: 'Infusion Taken'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        tooltip: 'Add New Log',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              // i want to add size to the bottom sheet
              return SizedBox(
                height: 200,
                child: ListView(
                  padding: EdgeInsets.all(20.0),
                  children: [
                    ListTile(
                      leading: Icon(Icons.add_circle, color: Colors.redAccent),
                      title: Text('Log New Bleeding Episode'),
                      onTap: () {
                        // Handle adding a bleeding episode
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.add_circle, color: Colors.green),
                      title: Text('Log New Infusion Taken'),
                      onTap: () {
                        // Handle adding an infusion taken
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SampleScreen extends StatelessWidget {
  final String screenTitle;
  const SampleScreen({super.key, required this.screenTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            screenTitle,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          // Placeholder ListTile for backend reference
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.grey),
            title: Text(
              screenTitle == 'Bleeding Episodes'
                  ? 'Sample Bleeding Episode'
                  : 'Sample Infusion Taken',
              style: TextStyle(color: Colors.black54),
            ),
            subtitle: Text(
              screenTitle == 'Bleeding Episodes'
                  ? 'Details about a bleeding episode go here.'
                  : 'Details about an infusion taken go here.',
              style: TextStyle(color: Colors.black38),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
