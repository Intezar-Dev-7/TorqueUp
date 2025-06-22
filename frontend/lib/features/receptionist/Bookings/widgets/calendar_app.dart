import 'package:flutter/material.dart';

import '../widgets/custom_calendar_widget.dart';

// Demo App
class CalendarApp extends StatefulWidget {
  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Calendar',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Custom Calendar Widget'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCalendarWidget(
                  initialDate: DateTime(2021, 9, 19),
                  // September 2021 with 19th selected
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                    print('Selected date: $date');
                  },
                ),
                if (selectedDate != null) ...[
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Selected Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
