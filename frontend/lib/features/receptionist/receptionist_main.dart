import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/screens/customer_screen.dart';
import 'package:frontend/features/receptionist/screens/dashboard_screen.dart';
import 'package:frontend/features/receptionist/screens/notification_screen.dart';
import '../admin/Bookings/screens/bookings_screen.dart';
import '../admin/Mechanics/screens/mechanics_screen.dart';
import '../admin/services/screens/services_screen.dart';
import 'layout/receptionist_scaffold.dart';

class ReceptionistMainScreen extends StatefulWidget {
  const ReceptionistMainScreen({super.key});

  @override
  _ReceptionistMainScreenState createState() => _ReceptionistMainScreenState();
}

class _ReceptionistMainScreenState extends State<ReceptionistMainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    DashboardScreen(),
    const BookingsScreen(),
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
