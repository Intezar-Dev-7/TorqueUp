import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/screens/dashboard_screen.dart';
import '../admin/Bookings/screens/bookings_screen.dart';
import '../customers/screens/customers_screen.dart';
import '../admin/Mechanics/screens/mechanics_screen.dart';
import '../admin/services/screens/services_screen.dart';
import 'layout/receptionist_scaffold.dart';

class ReceptionistMain extends StatefulWidget {
  const ReceptionistMain({super.key});

  @override
  State<ReceptionistMain> createState() => _ReceptionistMainState();
}

class _ReceptionistMainState extends State<ReceptionistMain> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const DashboardScreen(),
    const BookingsScreen(),
    const CustomersScreen(),
    const ServicesScreen(),
    const MechanicsScreen(),
  ];

  void onNavItemTap(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return ReceptionistScaffold(
      body: pages[selectedIndex],
      onItemSelected: onNavItemTap,
      selectedIndex: selectedIndex,
    );
  }
}
