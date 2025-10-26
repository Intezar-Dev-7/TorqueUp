import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Staff/widgets/interns.dart';
import 'package:frontend/features/admin/Staff/widgets/mechanics.dart';
import 'package:frontend/features/admin/Staff/widgets/other_employees.dart';
import 'package:frontend/utils/colors.dart';

class AdminStaffScreen extends StatefulWidget {
  const AdminStaffScreen({super.key});

  @override
  State<AdminStaffScreen> createState() => _AdminStaffScreenState();
}

class _AdminStaffScreenState extends State<AdminStaffScreen> {
  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.admin_bg,
      appBar: _buildModernAppBar(screenWidth),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile(screenWidth) ? 12 : 20),
        child: _buildResponsiveLayout(screenWidth),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(double screenWidth) {
    return AppBar(
      toolbarHeight: isMobile(screenWidth) ? 100 : 120,
      backgroundColor: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.black.withOpacity(0.1),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile(screenWidth) ? 8 : 16,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile(screenWidth) ? 8 : 10),
                  decoration: BoxDecoration(
                    color: AppColors.admin_primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.people_outline,
                    color: AppColors.admin_primary,
                    size: isMobile(screenWidth) ? 20 : 24,
                  ),
                ),
                SizedBox(width: isMobile(screenWidth) ? 8 : 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Staff Management',
                        style: TextStyle(
                          fontSize: isMobile(screenWidth) ? 18 : 22,
                          color: AppColors.text_dark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!isMobile(screenWidth)) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Manage mechanics, interns, and employees',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.text_grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildQuickStat(Icons.build_outlined, 'Mechanics', AppColors.admin_primary),
        const SizedBox(width: 12),
        _buildQuickStat(Icons.school_outlined, 'Interns', AppColors.status_pending),
        const SizedBox(width: 12),
        _buildQuickStat(Icons.person_outline, 'Others', AppColors.status_completed),
      ],
    );
  }

  Widget _buildQuickStat(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(double screenWidth) {
    if (isMobile(screenWidth)) {
      // Single column for mobile
      return Column(
        children: [
          const MechanicsWidget(),
          const SizedBox(height: 20),
          const InternsWidget(),
          const SizedBox(height: 20),
          const OtherEmployeesWidget(),
        ],
      );
    } else if (isTablet(screenWidth)) {
      // Two columns for tablet
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: MechanicsWidget()),
              const SizedBox(width: 20),
              const Expanded(child: InternsWidget()),
            ],
          ),
          const SizedBox(height: 20),
          const OtherEmployeesWidget(),
        ],
      );
    } else {
      // Three columns for desktop
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: MechanicsWidget()),
          const SizedBox(width: 20),
          const Expanded(child: InternsWidget()),
          const SizedBox(width: 20),
          const Expanded(child: OtherEmployeesWidget()),
        ],
      );
    }
  }
}
