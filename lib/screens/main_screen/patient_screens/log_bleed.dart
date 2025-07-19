// ...existing imports...
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogBleed extends StatefulWidget {
  const LogBleed({super.key});

  @override
  State<LogBleed> createState() => _LogBleedState();
}

class _LogBleedState extends State<LogBleed> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  int _step = 0;

  final List<String> _stepTitles = [
    'Date & Time',
    'Body Region',
    'Severity',
    'Photo',
    'Review'
  ];

  // Add controllers/fields for other steps as needed
  String _bodyRegion = '';
  String _severity = '';
  // For photo, you can use File or XFile if using image_picker

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      _timeController.text = DateFormat('hh:mm a').format(dt);
    }
  }

  void _setNow() {
    final now = DateTime.now();
    _dateController.text = DateFormat('yyyy-MM-dd').format(now);
    _timeController.text = DateFormat('hh:mm a').format(now);
  }

  void _nextStep() {
    if (_step < 4) setState(() => _step++);
  }

  void _prevStep() {
    if (_step > 0) setState(() => _step--);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('When did this happen?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Select the date and time of the symptom or bleed.'),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: _pickDate,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: _pickTime,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _setNow,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Set Automatically, Happening right now.'),
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Which body region?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Tap the area where the symptom or bleed occured.'),
            SizedBox(height: 20),
            // Replace with your body region selector widget
            DropdownButtonFormField<String>(
              value: _bodyRegion.isEmpty ? null : _bodyRegion,
              items: [
                'Head', 'Arm', 'Leg', 'Torso', 'Other'
              ].map((region) => DropdownMenuItem(value: region, child: Text(region))).toList(),
              onChanged: (val) => setState(() => _bodyRegion = val ?? ''),
              decoration: InputDecoration(labelText: 'Body Region'),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Severity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Select how serious the bleed or symptom was'),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _severity.isEmpty ? null : _severity,
              items: [
                'Mild', 'Moderate', 'Severe'
              ].map((sev) => DropdownMenuItem(value: sev, child: Text(sev))).toList(),
              onChanged: (val) => setState(() => _severity = val ?? ''),
              decoration: InputDecoration(labelText: 'Severity'),
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Photo of Prescription or Bleed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Upload a photo of the prescription or the affected area'),
            SizedBox(height: 20),
            // TODO: Add image picker widget here
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement image picker
              },
              icon: Icon(Icons.photo_camera),
              label: Text('Upload Photo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Review & Save', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 10),
            Text('Date: ${_dateController.text}'),
            Text('Time: ${_timeController.text}'),
            Text('Body Region: $_bodyRegion'),
            Text('Severity: $_severity'),
            // TODO: Show photo preview if available
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_stepTitles.length, (index) {
        final isActive = index == _step;
        final isCompleted = index < _step;
        return Expanded(
          child: Column(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: isActive
                    ? Colors.redAccent
                    : isCompleted
                        ? Colors.green
                        : Colors.grey.shade300,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: isActive || isCompleted ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                _stepTitles[index],
                style: TextStyle(
                  fontSize: 12,
                  color: isActive
                      ? Colors.redAccent
                      : isCompleted
                          ? Colors.green
                          : Colors.black54,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Bleed'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              _buildStepper(),
              SizedBox(height: 24),
              Expanded(child: _buildStepContent()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_step > 0)
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _prevStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 165, 165),
                          foregroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Back', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  if (_step < 4)
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Next'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Turn each into Vertical Multi Step Form