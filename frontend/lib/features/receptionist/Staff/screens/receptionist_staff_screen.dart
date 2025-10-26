import 'package:flutter/material.dart';

import 'package:frontend/features/receptionist/Staff/widgets/add_staff_form.dart';
import 'package:frontend/features/receptionist/Staff/widgets/interns_widget.dart';
import 'package:frontend/features/receptionist/Staff/widgets/mechanics.widget.dart';
import 'package:frontend/features/receptionist/Staff/widgets/otherEmployee_widget.dart';
import 'package:frontend/utils/colors.dart';

class ReceptionistStaffScreen extends StatefulWidget {
  const ReceptionistStaffScreen({super.key});

  @override
  State<ReceptionistStaffScreen> createState() =>
      _ReceptionistStaffScreenState();
}

class _ReceptionistStaffScreenState extends State<ReceptionistStaffScreen> {
  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sky_blue_bg,
      appBar: _buildModernAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.all(isMobile(constraints.maxWidth) ? 16 : 20),
            child: _buildResponsiveLayout(constraints.maxWidth),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      toolbarHeight: isMobile(screenWidth) ? 140 : 120,
      backgroundColor: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.black.withOpacity(0.1),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.sky_blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.groups_rounded,
                          color: AppColors.sky_blue,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Staff',
                              style: TextStyle(
                                fontSize: isMobile(screenWidth) ? 18 : 22,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Edit, Update and Delete employees',
                              style: TextStyle(
                                fontSize: isMobile(screenWidth) ? 12 : 14,
                                color: AppColors.text_grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.sky_blue, AppColors.sky_blue_light],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.sky_blue.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.transparent,
                      shadowColor: AppColors.transparent,
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: isMobile(screenWidth) ? 12 : 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddStaff(),
                      );
                    },
                    child:
                        isMobile(screenWidth)
                            ? Icon(Icons.add_rounded, color: AppColors.white)
                            : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add_rounded, color: AppColors.white),
                                const SizedBox(width: 8),
                                Text(
                                  'Add Staff',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(double screenWidth) {
    if (isMobile(screenWidth)) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Mechanics(),
            const SizedBox(height: 20),
            Interns(),
            const SizedBox(height: 20),
            OtherEmployees(),
          ],
        ),
      );
    } else if (isTablet(screenWidth)) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Mechanics()),
                const SizedBox(width: 20),
                Expanded(child: Interns()),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: screenWidth / 2 - 10),
              child: OtherEmployees(),
            ),
          ],
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Mechanics()),
          const SizedBox(width: 20),
          Expanded(child: Interns()),
          const SizedBox(width: 20),
          Expanded(child: OtherEmployees()),
        ],
      );
    }
  }
}
