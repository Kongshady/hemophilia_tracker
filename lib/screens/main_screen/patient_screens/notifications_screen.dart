import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/firestore.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> _markAllAsRead() async {
    if (uid.isNotEmpty) {
      await _firestoreService.markAllNotificationsAsRead(uid);
    }
  }

  Future<void> _deleteAll() async {
    if (uid.isNotEmpty) {
      await _firestoreService.deleteAllNotifications(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (outerContext) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifications',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (!outerContext.mounted) return;
                showModalBottomSheet<void>(
                  context: outerContext,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.white,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leading: Icon(Icons.mark_email_read),
                            title: Text('Mark All as Read'),
                            onTap: () async {
                              await _markAllAsRead();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.delete, color: Colors.red),
                            title: Text('Delete All'),
                            onTap: () async {
                              await _deleteAll();
                              Navigator.pop(context);
                            },
                          ),
                        ],
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
                        stream: _firestoreService.getNotifications(uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            print('Firestore error: ${snapshot.error}');
                            // Check specific error types
                            if (snapshot.error.toString().contains('permission-denied')) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.security, size: 48, color: Colors.red),
                                    SizedBox(height: 16),
                                    Text('Permission denied'),
                                    Text('Check Firestore security rules'),
                                  ],
                                ),
                              );
                            } else if (snapshot.error.toString().contains('failed-precondition')) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.warning, size: 48, color: Colors.orange),
                                    SizedBox(height: 16),
                                    Text('Index required'),
                                    Text('Create composite index in Firestore'),
                                  ],
                                ),
                              );
                            }
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error, size: 48, color: Colors.red),
                                  SizedBox(height: 16),
                                  Text('Error loading notifications'),
                                  Text('${snapshot.error}', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            );
                          }

                          final docs = snapshot.data?.docs ?? [];
                          if (docs.isEmpty) {
                            return Center(child: Text('No notifications.'));
                          }

                          return ListView.separated(
                            itemCount: docs.length,
                            separatorBuilder: (_, __) => SizedBox(height: 5),
                            itemBuilder: (context, index) {
                              final doc = docs[index];
                              final data = doc.data() as Map<String, dynamic>;
                              return NotificationList(
                                text: data['text'] ?? '',
                                time: data['timestamp'] != null
                                    ? _formatTime(data['timestamp'])
                                    : '',
                                read: data['read'] ?? false,
                                onTap: () async {
                                  if (!data['read']) {
                                    await _firestoreService.markNotificationAsRead(doc.id);
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
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
  final VoidCallback? onTap;

  const NotificationList({
    super.key,
    required this.text,
    required this.time,
    required this.read,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: read ? Colors.grey.shade200 : Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
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
        trailing: read ? null : Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
