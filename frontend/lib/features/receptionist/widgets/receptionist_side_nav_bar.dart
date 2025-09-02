import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:frontend/features/admin/Staff/screens/staff.dart';
import 'package:frontend/features/receptionist/Bookings/screens/receptionist_booking_screen.dart';
import 'package:frontend/features/receptionist/Customers/screens/customer_screen.dart';
import 'package:frontend/features/receptionist/Dashboard/screens/receptionist_dashboard_screen.dart';
import 'package:frontend/features/receptionist/Services/screens/services_screen.dart';
import 'package:frontend/features/receptionist/Settings/screens/receptionist_settings_screen.dart';

class ReceptionistSideNavBar extends StatefulWidget {
  const ReceptionistSideNavBar({super.key});

  @override
  State<ReceptionistSideNavBar> createState() => ReceptionistSideNavBarState();
}

class ReceptionistSideNavBarState extends State<ReceptionistSideNavBar> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              hoverColor: Colors.black38,

              selectedColor: Colors.black,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 170,
                    maxWidth: 170,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/appLogo/TorqueUpLogo.png', // ✅ Replace with your logo
                  width: 200,
                ),
                const Divider(indent: 8.0, endIndent: 8.0),
              ],
            ),
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.dashboard),
              ),
              SideMenuItem(
                title: 'Bookings',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.calendar_today),
              ),
              SideMenuItem(
                title: 'Customers',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.people),
              ),
              SideMenuItem(
                title: 'Services',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.build),
              ),
              SideMenuItem(
                title: 'Staff',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.group),
              ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: const Icon(Icons.settings),
              ),
            ],
          ),

          // ✅ PageView for content
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(), // prevent swipe
              children: [
                ReceptionistDashboardScreen(),
                BookingsScreen(),
                CustomerScreen(),
                ServicesScreen(),
                StaffScreen(),
                ReceptionistSettingsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
