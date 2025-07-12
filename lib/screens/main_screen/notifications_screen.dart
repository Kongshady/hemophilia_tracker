import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Opens a showmodalbottomsheet with clear all, mark all as read and cancel button
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.amber,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Add mark all as read functionality
                            },
                            child: const Text('Mark All as Read'),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Add delete all functionality
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Delete All'),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(FontAwesomeIcons.ellipsisVertical),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TODAY'), // Sample
            // Handles and displays all notifications
            SizedBox(height: 10,),
            Expanded(
              child: ListView(
                children: [
                  NotificationList(),
                  SizedBox(height: 5),
                  NotificationList(),
                  SizedBox(height: 5),
                  NotificationList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue,
          ),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text('notification text here'),
        subtitle: Text('1h ago'),
        // Remove tileColor from ListTile, handled by Container
      ),
    );
  }
}
