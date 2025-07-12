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
          'BleedWatchPH',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
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
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting and quick info
              Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Here’s your health summary for today.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 22),

              // Health Overview Section
              Text(
                'Health Overview',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              // 2x2 grid: 2 top, 1 bottom (wellness)
              Row(
                children: [
                  Expanded(
                    child: _DashboardStatCard(
                      icon: FontAwesomeIcons.capsules,
                      iconColor: Colors.blueAccent,
                      label: 'Next Infusion',
                      value: 'No schedule',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _DashboardStatCard(
                      icon: FontAwesomeIcons.droplet,
                      iconColor: Colors.redAccent,
                      label: 'Last Bleed',
                      value: 'None recorded',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Wellness container spans full width
              _DashboardStatCard(
                icon: FontAwesomeIcons.heartPulse,
                iconColor: Colors.green,
                label: 'Wellness',
                value: 'Good',
                isFullWidth: true,
              ),
              SizedBox(height: 28),

              // Reminders Section
              Text(
                'Reminders',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              _DashboardListSection(
                items: [
                  {
                    'icon': FontAwesomeIcons.syringe,
                    'color': Colors.redAccent,
                    'title': 'Infusion Reminder',
                    'subtitle': 'No infusion scheduled today',
                  },
                  {
                    'icon': FontAwesomeIcons.calendarCheck,
                    'color': Colors.blueAccent,
                    'title': 'Doctor Appointment',
                    'subtitle': 'No appointments today',
                  },
                ],
                emptyText: 'No reminders for today.',
              ),
              SizedBox(height: 28),

              // Recent Activity Section
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              _DashboardListSection(
                items: [
                  {
                    'icon': FontAwesomeIcons.droplet,
                    'color': Colors.redAccent,
                    'title': 'Logged Bleed',
                    'subtitle': 'Left knee, 2 days ago',
                  },
                  {
                    'icon': FontAwesomeIcons.capsules,
                    'color': Colors.blueAccent,
                    'title': 'Infusion Taken',
                    'subtitle': 'Factor VIII, 3 days ago',
                  },
                ],
                emptyText: 'No recent activity.',
              ),
              SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

// Minimalist stat card for dashboard
class _DashboardStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool isFullWidth;

  const _DashboardStatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      margin: isFullWidth ? EdgeInsets.symmetric(horizontal: 0) : null,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: isFullWidth ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28),
          SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Minimalist list section for reminders and activity
class _DashboardListSection extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String emptyText;

  const _DashboardListSection({
    required this.items,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          emptyText,
          style: TextStyle(color: Colors.black54),
        ),
      );
    }
    return Column(
      children: items.map((item) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
          leading: Icon(item['icon'], color: item['color'], size: 24),
          title: Text(
            item['title'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          subtitle: Text(item['subtitle'], style: TextStyle(fontSize: 13)),
        );
      }).toList(),
    );
  }
}
