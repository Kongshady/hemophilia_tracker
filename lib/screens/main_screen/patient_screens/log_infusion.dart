import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogInfusionScreen extends StatefulWidget {
  const LogInfusionScreen({super.key});

  @override
  State<LogInfusionScreen> createState() => _LogInfusionScreenState();
}

class _LogInfusionScreenState extends State<LogInfusionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Set default date and time to current
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _saveInfusion() async {
    if (!_formKey.currentState!.validate() ||
        _selectedDate == null ||
        _selectedTime == null) {
      return;
    }
    setState(() => _isSaving = true);

    final infusionData = {
      'medication': _medicationController.text.trim(),
      'doseIU': int.tryParse(_doseController.text.trim()) ?? 0,
      'date': Timestamp.fromDate(
        DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        ),
      ),
      'notes': _notesController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance.collection('infusions').add(infusionData);

    setState(() => _isSaving = false);
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log Infusion',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and subtitle
              Text(
                'Record your infusion',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Keep track of your medication intake',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 28),
              
              Expanded(
                child: ListView(
                  children: [
                    // Medication field
                    TextFormField(
                      controller: _medicationController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.medical_services_outlined,
                          color: Colors.deepPurple,
                        ),
                        labelText: 'Medication',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter medication' : null,
                    ),
                    SizedBox(height: 20),
                    
                    // Dose field
                    TextFormField(
                      controller: _doseController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.colorize,
                          color: Colors.deepPurple,
                        ),
                        labelText: 'Dose (IU)',
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) => v == null || v.isEmpty ? 'Enter dose' : null,
                    ),
                    SizedBox(height: 20),
                    
                    // Date and Time row
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: _pickDate,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.deepPurple,
                                ),
                                labelText: 'Date',
                                border: UnderlineInputBorder(),
                              ),
                              child: Text(
                                _selectedDate == null
                                    ? 'Select date'
                                    : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  color: _selectedDate == null ? Colors.black54 : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: _pickTime,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.access_time,
                                  color: Colors.deepPurple,
                                ),
                                labelText: 'Time',
                                border: UnderlineInputBorder(),
                              ),
                              child: Text(
                                _selectedTime == null
                                    ? 'Select time'
                                    : _selectedTime!.format(context),
                                style: TextStyle(
                                  color: _selectedTime == null ? Colors.black54 : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    
                    // Notes field
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.note_outlined,
                          color: Colors.deepPurple,
                        ),
                        labelText: 'Notes (Optional)',
                        border: UnderlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 28),
                    
                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _isSaving ? null : _saveInfusion,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: _isSaving 
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(Icons.save, color: Colors.white),
                        label: Text(
                          'Save Infusion',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
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
