import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import '../../../utils/colors.dart';
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
    {'icon': NavIcons.dashboard, 'title': 'Dashboard'},
    {'icon': NavIcons.booking, 'title': 'Bookings'},
    {'icon': NavIcons.customer, 'title': 'Customers'},
    {'icon': NavIcons.services, 'title': 'Services'},
    {'icon': NavIcons.mechanics, 'title': 'Mechanics'},
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
              color: AppColors.grey,
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
