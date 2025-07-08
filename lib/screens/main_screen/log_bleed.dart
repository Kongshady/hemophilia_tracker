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
  final PageController _pageController = PageController();
  int _currentPage = 0;

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

  void _goToNextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = 4; // Adjust if you add more pages

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.help, size: 30)),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                // Page 1
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Log Entry',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                          ),
                          Text(
                            'When did this happen?',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date'),
                              SizedBox(height: 5),
                              TextField(
                                controller: _dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: _pickDate,
                                    icon: Icon(Icons.date_range),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Time'),
                              SizedBox(height: 5),
                              TextField(
                                controller: _timeController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: _pickTime,
                                    icon: Icon(Icons.access_time),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: _setNow,
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.redAccent,
                              ),
                              child: Text('Happening Right Now!'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('Step 1 of $totalPages'),
                    ],
                  ),
                ),
                // Page 2 (example, you can add more pages as needed)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Page 2', style: TextStyle(fontSize: 24)),
                      SizedBox(height: 8),
                      Text('Step 2 of $totalPages'),
                    ],
                  ),
                ),
                // Page 3
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Page 3', style: TextStyle(fontSize: 24)),
                      SizedBox(height: 8),
                      Text('Step 3 of $totalPages'),
                    ],
                  ),
                ),
                // Page 4
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Page 4', style: TextStyle(fontSize: 24)),
                      SizedBox(height: 8),
                      Text('Step 4 of $totalPages'),
                    ],
                  ),
                ),
              ],
            ),
            // Floating navigation buttons
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: FilledButton(
                        onPressed: _goToPreviousPage,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Back'),
                      ),
                    )
                  else
                    SizedBox(width: 90), // To keep spacing
                  if (_currentPage < totalPages - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: FilledButton(
                        onPressed: _goToNextPage,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Next'),
                      ),
                    )
                  else
                    SizedBox(width: 90), // To keep spacing
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}