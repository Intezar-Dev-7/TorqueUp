import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Staff/widgets/edit_employee_dialog.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';
import 'package:frontend/utils/colors.dart';

class EmployeesProfileScreen extends StatefulWidget {
  final Map<String, dynamic> staff;
  const EmployeesProfileScreen({super.key, required this.staff});

  @override
  State<EmployeesProfileScreen> createState() => _EmployeesProfileScreenState();
}

class _EmployeesProfileScreenState extends State<EmployeesProfileScreen> {
  final staffService = ReceptionistStaffServices();

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  Widget build(BuildContext context) {
    final staff = widget.staff;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.admin_bg,
      appBar: _buildModernAppBar(screenWidth),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile(screenWidth) ? 16 : 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(staff, screenWidth),
                const SizedBox(height: 32),
                _buildInfoCards(staff, screenWidth),
                const SizedBox(height: 32),
                if (staff['skills'] != null && staff['skills'] is List)
                  _buildSkillsSection(staff),
                if (staff['about'] != null) _buildAboutSection(staff),
                const SizedBox(height: 32),
                _buildActionButtons(staff, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(double screenWidth) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.black.withOpacity(0.1),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.admin_primary),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Employee Profile",
        style: TextStyle(
          color: AppColors.text_dark,
          fontSize: isMobile(screenWidth) ? 18 : 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> staff, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(isMobile(screenWidth) ? 20 : 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isMobile(screenWidth)
          ? Column(
        children: [
          _buildAvatar(staff),
          const SizedBox(height: 20),
          _buildProfileInfo(staff),
        ],
      )
          : Row(
        children: [
          _buildAvatar(staff),
          const SizedBox(width: 32),
          Expanded(child: _buildProfileInfo(staff)),
        ],
      ),
    );
  }

  Widget _buildAvatar(Map<String, dynamic> staff) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.admin_primary,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.admin_primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundImage: staff['avatar'] != null && staff['avatar'].isNotEmpty
            ? NetworkImage(staff['avatar'])
            : const AssetImage('assets/general_icons/employee.png')
        as ImageProvider,
        backgroundColor: AppColors.admin_primary.withOpacity(0.1),
      ),
    );
  }

  Widget _buildProfileInfo(Map<String, dynamic> staff) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          staff['staffName'] ?? 'No Name',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.text_dark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.admin_primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.admin_primary.withOpacity(0.3),
            ),
          ),
          child: Text(
            staff['staffRole'] ?? 'Employee',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.admin_primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (staff['staffContactNumber'] != null)
          _buildContactRow(
            Icons.phone_outlined,
            staff['staffContactNumber'],
          ),
        if (staff['staffEmail'] != null)
          _buildContactRow(
            Icons.email_outlined,
            staff['staffEmail'],
          ),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.admin_primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: AppColors.admin_primary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.text_dark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards(Map<String, dynamic> staff, double screenWidth) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildInfoCard(
          "Experience",
          staff['staffExperience'] ?? 'N/A',
          Icons.work_outline,
          AppColors.admin_primary,
          screenWidth,
        ),
        _buildInfoCard(
          "Joined",
          staff['createdAt'] != null
              ? staff['createdAt'].substring(0, 10)
              : 'N/A',
          Icons.calendar_today_outlined,
          AppColors.status_completed,
          screenWidth,
        ),
        _buildInfoCard(
          "Department",
          staff['staffRole'] ?? 'N/A',
          Icons.business_outlined,
          AppColors.status_pending,
          screenWidth,
        ),
      ],
    );
  }

  Widget _buildInfoCard(
      String title,
      String value,
      IconData icon,
      Color color,
      double screenWidth,
      ) {
    return Container(
      width: isMobile(screenWidth)
          ? (screenWidth - 48) / 2
          : isTablet(screenWidth)
          ? 220
          : 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.text_dark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.text_grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(Map<String, dynamic> staff) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.admin_primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.star_outline,
                  color: AppColors.admin_primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Skills & Expertise",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text_dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List<Widget>.from(
              (staff['skills'] as List).map(
                    (skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.admin_primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.admin_primary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      color: AppColors.admin_primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(Map<String, dynamic> staff) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.admin_primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.info_outline,
                  color: AppColors.admin_primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "About",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text_dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            staff['about'],
            style: TextStyle(
              fontSize: 15,
              color: AppColors.text_dark,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> staff, double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isMobile(screenWidth)
          ? Column(
        children: [
          _buildEditButton(staff),
          const SizedBox(height: 12),
          _buildDeleteButton(staff),
        ],
      )
          : Row(
        children: [
          Expanded(child: _buildEditButton(staff)),
          const SizedBox(width: 16),
          Expanded(child: _buildDeleteButton(staff)),
        ],
      ),
    );
  }

  Widget _buildEditButton(Map<String, dynamic> staff) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.admin_primary,
            AppColors.admin_primary_light,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.admin_primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          final updatedStaff = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (context) => EditEmployeeDialog(staff: staff),
          );
          if (updatedStaff != null) {
            setState(() {
              widget.staff.addAll(updatedStaff);
            });
          }
        },
        icon: Icon(Icons.edit_outlined, color: AppColors.white),
        label: Text(
          "Edit Profile",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(Map<String, dynamic> staff) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          _showDeleteConfirmation(staff);
        },
        icon: Icon(Icons.delete_outline, color: AppColors.white),
        label: Text(
          "Remove Employee",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> staff) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Confirm Deletion",
                style: TextStyle(
                  color: AppColors.text_dark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to remove ${staff['staffName']}? This action cannot be undone.',
          style: TextStyle(
            color: AppColors.text_dark,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: AppColors.text_grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                staffService.deleteEmployee(
                  context: context,
                  staffId: staff['_id'],
                );
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to staff list
              },
              child: Text(
                "Delete",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
