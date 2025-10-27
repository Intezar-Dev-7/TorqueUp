import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:frontend/features/receptionist/Bookings/screens/receptionist_booking_screen.dart';
import 'package:frontend/features/receptionist/Dashboard/screens/receptionist_dashboard_screen.dart';
import 'package:frontend/features/receptionist/Inventory/screens/receptionist_inventory_screen.dart';
import 'package:frontend/features/receptionist/Settings/screens/receptionist_settings_screen.dart';
import 'package:frontend/features/receptionist/Staff/screens/receptionist_staff_screen.dart';
import 'package:frontend/utils/colors.dart';

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
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              // Background color for the sidebar
              backgroundColor: AppColors.white,
              // Hover state with sky blue
              hoverColor: AppColors.sky_blue.withOpacity(0.1),
              // Selected item with sky blue gradient
              selectedColor: AppColors.sky_blue,
              // Selected icon color - white on sky blue background
              selectedIconColor: AppColors.white,
              // Selected text - white on sky blue background
              selectedTitleTextStyle: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              // Unselected icon color - grey
              unselectedIconColor: AppColors.text_grey,
              // Unselected text
              unselectedTitleTextStyle: TextStyle(
                color: AppColors.text_dark,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              // Item decoration
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              // Item height and padding
              itemHeight: 54,
              itemInnerSpacing: 12,
              itemBorderRadius: const BorderRadius.all(Radius.circular(10)),
              // Icon size
              iconSize: 22,
            ),
            title: Column(
              children: [
                const SizedBox(height: 24),
                // Logo with padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(
                    'assets/appLogo/TorqueUpLogo.png',
                    width: 160,
                  ),
                ),
                const SizedBox(height: 20),
                // Divider with sky blue tint
                Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 1,
                  color: AppColors.border_grey.withOpacity(0.5),
                ),
                const SizedBox(height: 8),
              ],
            ),
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: Icon(Icons.dashboard_outlined, color: AppColors.sky_blue),
              ),
              SideMenuItem(
                title: 'Bookings',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.sky_blue,
                ),
              ),
              SideMenuItem(
                title: 'Inventory',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.sky_blue,
                ),
              ),
              SideMenuItem(
                title: 'Staff',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: Icon(Icons.groups_outlined, color: AppColors.sky_blue),
              ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: Icon(Icons.settings_outlined, color: AppColors.sky_blue),
              ),
            ],
            footer: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.sky_blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.sky_blue.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.sky_blue,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Receptionist Panel',
                        style: TextStyle(
                          color: AppColors.sky_blue,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Vertical divider between sidebar and content
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: AppColors.border_grey.withOpacity(0.3),
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
