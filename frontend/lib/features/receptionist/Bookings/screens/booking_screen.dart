import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/compact_calendar.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/custom_calendar_widget.dart';
import 'package:frontend/features/receptionist/widgets/cus_elevated_button.dart';
import 'package:frontend/utils/colors.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppColors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("this is date"),
            CusElevatedButton(buttonText: 'New Booking', onPressed: () {}),
          ],
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.grey30,
              child: CustomCalendarWidget(),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.grey30,
              child: CompactCalendarWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
