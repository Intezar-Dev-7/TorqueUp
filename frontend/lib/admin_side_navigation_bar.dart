import 'package:easy_sidemenu/easy_sidemenu.dart'
    show
        SideMenu,
        SideMenuController,
        SideMenuDisplayMode,
        SideMenuItem,
        SideMenuStyle;
import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Bookings/screens/admin_bookings_screen.dart';
import 'package:frontend/features/admin/Dashbaord/screens/admin_dashboard_screen.dart';
import 'package:frontend/features/admin/Inventory/screens/admin_inventory_screen.dart';
import 'package:frontend/features/admin/Staff/screens/admin_staff_screeen.dart';
import 'package:frontend/features/admin/ReportsAndAnalytics/screens/reports_and_analytics_screen.dart';
import 'package:frontend/features/admin/Settings/screens/admin_settings_screen.dart';
import 'package:frontend/utils/colors.dart';
import 'package:iconsax/iconsax.dart';

class AdminSideNavigationBar extends StatefulWidget {
  const AdminSideNavigationBar({super.key});

  @override
  State<AdminSideNavigationBar> createState() => _AdminSideNavigationBarState();
}

class _AdminSideNavigationBarState extends State<AdminSideNavigationBar> {
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
      backgroundColor: AppColors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              // Background color for the sidebar
              backgroundColor: AppColors.white,
              // Hover state with admin teal
              hoverColor: AppColors.admin_primary.withOpacity(0.1),
              // Selected item with admin teal
              selectedColor: AppColors.admin_primary,
              // Selected icon color - white on teal background
              selectedIconColor: AppColors.white,
              // Selected text - white on teal background
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
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 170,
                      maxWidth: 170,
                    ),
                    child: Image.asset(
                      'assets/appLogo/TorqueUpLogo.png',
                      width: 160,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Divider with teal tint
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
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: Icon(
                  Icons.dashboard_outlined,
                  color: AppColors.admin_primary,
                ),
              ),
              SideMenuItem(
                title: 'Bookings',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: Icon(Iconsax.calendar, color: AppColors.admin_primary),
              ),
              SideMenuItem(
                title: 'Staff',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: Icon(Iconsax.people, color: AppColors.admin_primary),
              ),
              SideMenuItem(
                title: 'Inventory',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: Icon(Iconsax.box, color: AppColors.admin_primary),
              ),
              SideMenuItem(
                title: 'Reports & Analytics',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: Icon(Iconsax.chart, color: AppColors.admin_primary),
              ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) => sideMenu.changePage(index),
                icon: Icon(Iconsax.settings, color: AppColors.admin_primary),
              ),
            ],
            footer: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.admin_primary.withOpacity(0.1),
                      AppColors.admin_primary_light.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.admin_primary.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.admin_panel_settings_outlined,
                      color: AppColors.admin_primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Admin Panel',
                        style: TextStyle(
                          color: AppColors.admin_primary,
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
                AdminDashboardScreen(),
                AdminBookingsScreen(),
                AdminStaffScreen(),
                AdminInventoryScreen(),
                ReportsAndAnalyticsScreen(),
                AdminSettingsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
