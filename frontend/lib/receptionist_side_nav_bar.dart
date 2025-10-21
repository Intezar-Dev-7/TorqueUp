import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:frontend/features/receptionist/Bookings/screens/receptionist_booking_screen.dart';
import 'package:frontend/features/receptionist/Dashboard/screens/receptionist_dashboard_screen.dart';
import 'package:frontend/features/receptionist/Inventory/screens/receptionist_inventory_screen.dart';
import 'package:frontend/features/receptionist/Settings/screens/receptionist_settings_screen.dart';
import 'package:frontend/features/receptionist/Staff/screens/receptionist_staff_screen.dart';

class ReceptionistSideNavBar extends StatefulWidget {
  const ReceptionistSideNavBar({super.key});

  @override
  State<ReceptionistSideNavBar> createState() => ReceptionistSideNavBarState();
}

class ReceptionistSideNavBarState extends State<ReceptionistSideNavBar> {
  final PageController pageController = PageController();
  final SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    super.initState();
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define default unselected icon color
    const Color unselectedIconColor = Colors.black54;

    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              hoverColor: Colors.black26,
              selectedColor: Colors.black87,
              selectedTitleTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              unselectedIconColor: unselectedIconColor,
              unselectedTitleTextStyle: const TextStyle(color: Colors.black87),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            title: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset('assets/appLogo/TorqueUpLogo.png', width: 160),
                const Divider(indent: 12, endIndent: 12, thickness: 1),
              ],
            ),
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.dashboard, color: Colors.blue),
              ),
              SideMenuItem(
                title: 'Bookings',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.calendar_today, color: Colors.orange),
              ),

              SideMenuItem(
                title: 'Inventory',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.inventory_2, color: Colors.purple),
              ),

              SideMenuItem(
                title: 'Staff',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.group, color: Colors.redAccent),
              ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.settings, color: Colors.brown),
              ),
            ],
          ),

          // PageView for content
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                ReceptionistDashboardScreen(),
                BookingsScreen(),
                ReceptionistInventoryScreen(),
                ReceptionistStaffScreen(),
                ReceptionistSettingsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
