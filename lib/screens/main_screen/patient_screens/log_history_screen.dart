import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'log_bleed.dart'; // adjust path if needed

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
    // Ensure Hive box is open
    Hive.openBox<BleedLog>('bleed_logs');
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
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
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
        children: [
          // Bleeding Episodes tab: show Hive logs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Bleeding Episodes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box<BleedLog>('bleed_logs').listenable(),
                    builder: (context, Box<BleedLog> box, _) {
                      if (box.isEmpty) {
                        return Center(
                          child: Text(
                            'No bleeding episodes logged yet.',
                            style: TextStyle(color: Colors.black54),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          final log = box.getAt(index);
                          if (log == null) return SizedBox.shrink();
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: ListTile(
                              leading:
                                  Icon(Icons.bloodtype, color: Colors.redAccent),
                              title: Text('${log.bodyRegion} (${log.severity})'),
                              subtitle: Text('Date: ${log.date}\nTime: ${log.time}'),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                // Optionally show details
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Infusion Taken tab: keep placeholder
          const SampleScreen(screenTitle: 'Infusion Taken'),
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

// TODO: Logic for viewing and managing logs in bleeding episodes and infusion taken