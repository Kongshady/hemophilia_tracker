import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> _markAllAsRead() async {
    final notifications = await FirebaseFirestore.instance
        .collection('notifications')
        .where('uid', isEqualTo: uid)
        .where('read', isEqualTo: false)
        .get();
    for (var doc in notifications.docs) {
      await doc.reference.update({'read': true});
    }
  }

  Future<void> _deleteAll() async {
    final notifications = await FirebaseFirestore.instance
        .collection('notifications')
        .where('uid', isEqualTo: uid)
        .get();
    for (var doc in notifications.docs) {
      await doc.reference.delete();
    }
  }

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
            icon: Icon(Icons.send, color: Colors.redAccent),
            tooltip: 'Send Test Notification',
            onPressed: () async {
              await FirebaseFirestore.instance.collection('notifications').add({
                'uid': uid,
                'text': 'This is a test notification!',
                'timestamp': Timestamp.now(),
                'read': false,
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notification sent!')),
              );
            },
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              await _markAllAsRead();
                              Navigator.pop(context);
                            },
                            child: const Text('Mark All as Read'),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              await _deleteAll();
                              Navigator.pop(context);
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
            Text('TODAY'),
            SizedBox(height: 10),
            Expanded(
              child: uid.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('notifications')
                          .where('uid', isEqualTo: uid)
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final docs = snapshot.data?.docs ?? [];
                        if (docs.isEmpty) {
                          return Center(child: Text('No notifications.'));
                        }
                        return ListView.separated(
                          itemCount: docs.length,
                          separatorBuilder: (_, __) => SizedBox(height: 5),
                          itemBuilder: (context, index) {
                            final data = docs[index].data() as Map<String, dynamic>;
                            return NotificationList(
                              text: data['text'] ?? '',
                              time: data['timestamp'] != null
                                  ? _formatTime(data['timestamp'])
                                  : '',
                              read: data['read'] ?? false,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(dynamic timestamp) {
    if (timestamp is Timestamp) {
      final dt = timestamp.toDate();
      final now = DateTime.now();
      final diff = now.difference(dt);
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      return '${dt.month}/${dt.day}/${dt.year}';
    }
    return '';
  }
}

class NotificationList extends StatelessWidget {
  final String text;
  final String time;
  final bool read;

  const NotificationList({
    super.key,
    required this.text,
    required this.time,
    required this.read,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: read ? Colors.grey.shade200 : Colors.blueGrey.shade100,
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
        title: Text(text),
        subtitle: Text(time),
      ),
    );
  }
}
