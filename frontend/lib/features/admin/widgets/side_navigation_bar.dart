import 'package:easy_sidemenu/easy_sidemenu.dart'
    show
        SideMenu,
        SideMenuController,
        SideMenuDisplayMode,
        SideMenuItem,
        SideMenuStyle;
import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Bookings/screens/bookings_screen.dart';
import 'package:frontend/features/admin/Dashbaord/screens/dashboard_screen.dart';
import 'package:frontend/features/admin/Inventory/screens/inventory_screen.dart';
import 'package:frontend/features/admin/Mechanics/screens/mechanics_screen.dart';
import 'package:frontend/features/admin/ReportsAndAnalytics/screens/reports_and_analytics_screen.dart';
import 'package:frontend/features/admin/Settings/screens/settings_screen.dart';
import 'package:frontend/features/receptionist/Services/screens/services_screen.dart';
import 'package:iconsax/iconsax.dart';

import '../../customers/screens/customers_screen.dart';

class SideNavigationBar extends StatefulWidget {
  const SideNavigationBar({super.key});

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
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
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              // showTooltip: false,
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
                  child: Image.asset(
                    'assets/appLogo/TorqueUpLogo.png',
                    width: 200,
                  ),
                ),
                const Divider(indent: 8.0, endIndent: 8.0),
              ],
            ),

            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenu.changePage(index); // ✅ This keeps the layout
                },
                icon: const Icon(Icons.home),
              ),
              SideMenuItem(
                title: 'Bookings',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Iconsax.calendar),
              ),
              SideMenuItem(
                title: 'Customers',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Iconsax.people),
              ),
              SideMenuItem(
                title: 'Services',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Iconsax.box),
              ),
              SideMenuItem(
                title: 'Mechanics',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Iconsax.people5),
              ),
              SideMenuItem(
                title: 'Inventory',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Iconsax.box_14),
              ),
              SideMenuItem(
                title: 'Reports & Analytics',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Iconsax.bill),
              ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Iconsax.settings),
              ),
            ],
          ),
          const VerticalDivider(width: 0),
          Expanded(
            child: PageView(
              controller: pageController,
              physics:
                  const NeverScrollableScrollPhysics(), // Optional: disable swiping
              children: const [
                DashBoardScreen(),
                BookingsScreen(),
                CustomersScreen(),
                ServicesScreen(),
                MechanicsScreen(),
                InventoryScreen(),
                ReportsAndAnalyticsScreen(),
                SettingsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
