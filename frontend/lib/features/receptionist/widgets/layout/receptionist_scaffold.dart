import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

import '../../../../utils/colors.dart';
import '../app_bar.dart';
import '../side_nav_bar.dart';

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
    {'icon': NavIcons.settings, 'title': 'Notifications'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints
    final bool isMobile = screenWidth < 600;        // Phone
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;  // Tablet
    final bool isDesktop = screenWidth >= 1024;    // Desktop

    // Determine sidebar behavior
    final bool showDrawer = isMobile;
    final bool showCollapsedSidebar = isTablet;
    final bool showExpandedSidebar = isDesktop;

    // Calculate sidebar width
    double sidebarWidth = 0;
    if (showExpandedSidebar) {
      sidebarWidth = 240;
    } else if (showCollapsedSidebar) {
      sidebarWidth = 70;
    }

    return Scaffold(
      // Drawer for mobile
      drawer: showDrawer
          ? Drawer(
        backgroundColor: AppColors.grey,
        child: SideNavBar(
          onTap: (index) {
            onItemSelected(index);
            Navigator.of(context).pop(); // Close drawer
          },
          selectedIndex: selectedIndex,
          navItems: navItems,
          isCollapsed: false, // Always show full nav in drawer
          showTooltips: false,// No tooltips needed in drawer
        ),
      )
          : null,

      // App bar for mobile (to show hamburger menu)
      appBar: showDrawer
          ? AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        title: Text(
          navItems[selectedIndex]['title'].toString(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      )
          : null,

      body: Row(
        children: [
          // Sidebar for tablet and desktop
          if (!showDrawer)
            Container(
              width: sidebarWidth,
              color: AppColors.grey,
              child: SideNavBar(
                onTap: onItemSelected,
                selectedIndex: selectedIndex,
                navItems: navItems,
                isCollapsed: showCollapsedSidebar,
                showTooltips: showCollapsedSidebar, // Show tooltips when collapsed
              ),
            ),

          // Main content area
          Expanded(
            child: Column(
              children: [
                // Custom app bar for tablet and desktop
                if (!showDrawer)
                  CustomAppBar(
                    title: navItems[selectedIndex]['title'].toString(),
                  ),

                // Body content
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}