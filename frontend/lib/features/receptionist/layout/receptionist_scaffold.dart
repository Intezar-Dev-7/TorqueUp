import 'package:flutter/material.dart';
import '../widgets/side_nav_bar.dart';
import '../widgets/app_bar.dart';

class ReceptionistScaffold extends StatelessWidget {
  final Widget body;
  final Function(int) onItemSelected;
  final int selectedIndex;

  ReceptionistScaffold({
    super.key,
    required this.body,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  final navItems = [
    {'icon': Icons.dashboard, 'title': 'Dashboard'},
    {'icon': Icons.calendar_today, 'title': 'Bookings'},
    {'icon': Icons.people, 'title': 'Customers'},
    {'icon': Icons.build, 'title': 'Services'},
    {'icon': Icons.engineering, 'title': 'Mechanics'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
          MediaQuery.of(context).size.width < 800
              ? Drawer(
                child: SideNavBar(
                  onTap: onItemSelected,
                  selectedIndex: selectedIndex,
                  navItems: navItems,
                ),
              )
              : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 800)
            Container(
              width: 220,
              color: Colors.grey[200],
              child: SideNavBar(
                onTap: onItemSelected,
                selectedIndex: selectedIndex,
                navItems: navItems,
              ),
            ),
          Expanded(
            child: Column(
              children: [CustomAppBar(title: navItems[selectedIndex]['title'].toString()), Expanded(child: body)],
            ),
          ),
        ],
      ),
    );
  }
}
