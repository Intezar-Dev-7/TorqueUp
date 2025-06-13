import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Bookings/screens/bookings_screen.dart';
import 'package:frontend/features/receptionist/Bookings/screens/booking_screen.dart';
import 'package:frontend/features/receptionist/Customers/screens/customer_screen.dart';
import 'package:frontend/features/receptionist/Dashboard/screens/dashboard_screen.dart';
import 'package:frontend/features/receptionist/Notifications/screens/notification_screen.dart';
import '../../Mechanics/screens/mechanics_screen.dart';
import '../../Services/screens/services_screen.dart';
import 'receptionist_scaffold.dart';

class ReceptionistMainScreen extends StatefulWidget {
  const ReceptionistMainScreen({super.key});

  @override
  _ReceptionistMainScreenState createState() => _ReceptionistMainScreenState();
}

class _ReceptionistMainScreenState extends State<ReceptionistMainScreen> {
  int selectedIndex = 1;

  final List<Widget> pages = [
    DashboardScreen(),
    const BookingScreen(),
    const CustomerScreen(),
    const ServicesScreen(),
    const MechanicsScreen(),
    const NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ReceptionistScaffold(
      selectedIndex: selectedIndex,
      onItemSelected: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      body: pages[selectedIndex],
    );
  }
}
