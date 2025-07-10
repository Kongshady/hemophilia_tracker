import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          'HemoTrack PH',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidBell),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidUser),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              // Greeting for the user
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text('Hello, Username!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Icon(FontAwesomeIcons.handSparkles, color: Colors.blueAccent, size: 35,)
                    ],
                  ),
                  SizedBox(height: 20,),
        
                  // Dashboard title
                  Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.dashboard, size: 30, color: Colors.redAccent,),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
        
                  SizedBox(height: 10,),
        
                  // Todays Reminder
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15)
                    ),
                    color: const Color.fromARGB(110, 64, 195, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Today\'s Reminder', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              Icon(FontAwesomeIcons.bellConcierge)
                            ],
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 300,
                            child: ListView(
                              children: [
                                // change to ListView Builder
                                ListTile(
                                  leading: Icon(Icons.construction),
                                  title: Text('Sample Only', style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text('This is a subtitle'),
                                  tileColor: Colors.grey,
                                ),
                                ListTile(
                                  leading: Icon(Icons.construction),
                                  title: Text('Sample Only', style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text('This is a subtitle'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.construction),
                                  title: Text('Sample Only', style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text('This is a subtitle'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.construction),
                                  title: Text('Sample Only', style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text('This is a subtitle'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),
        
                  // Recent Activitiy
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15)
                    ),
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              Icon(Icons.pie_chart)
                            ],
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 300,
                            child: ListView(
                              children: [
                                // change to ListView Builder
                                ListTile(
                                  leading: Icon(Icons.construction),
                                  title: Text('Sample Only', style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text('This is a subtitle'),
                                  tileColor: Colors.grey,
                                ),
                                ListTile(
                                  leading: Icon(Icons.construction),
                                  title: Text('Sample Only', style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text('This is a subtitle'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.construction),
                                  title: Text('Sample Only', style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text('This is a subtitle'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.construction),
                                  title: Text('Sample Only', style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text('This is a subtitle'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
