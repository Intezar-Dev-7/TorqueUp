import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Staff/widgets/edit_employee_info.dart';
import 'package:frontend/features/receptionist/data/provider/receptionist_staff_provider.dart';
import 'package:frontend/utils/constant/colors.dart';
import 'package:provider/provider.dart';

class StaffProfileScreen extends StatefulWidget {
  final Map<String, dynamic> staff;
  const StaffProfileScreen({super.key, required this.staff});

  @override
  State<StaffProfileScreen> createState() => _StaffProfileScreenState();
}

class _StaffProfileScreenState extends State<StaffProfileScreen> {
  late Map<String, dynamic> currentStaff;

  bool isMobile(double width) => width < 600;

  @override
  void initState() {
    super.initState();
    // Copy the staff object to state so we can refresh the UI if edited
    currentStaff = Map<String, dynamic>.from(widget.staff);
  }

  void editEmployeeInformation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.7,
            child: EditEmployeeInfoWidget(
              staffId: currentStaff['_id'] ?? '',
              staffName: currentStaff['staffName']?.toString() ?? '',
              staffRole: currentStaff['staffRole']?.toString() ?? '',
              staffExperience:
                  currentStaff['staffExperience']?.toString() ?? '',
              staffContactNumber:
                  currentStaff['staffContactNumber']?.toString() ?? '',
              staffEmail: currentStaff['staffEmail']?.toString() ?? '',
              staffAbout: currentStaff['about']?.toString() ?? '',
              staffSkills:
                  (currentStaff['skills'] as List<dynamic>?)
                      ?.map((e) => e.toString())
                      .toList() ??
                  [],
            ),
          ),
        );
      },
    ).then((updatedData) {
      if (updatedData != null && updatedData is Map<String, dynamic>) {
        setState(() {
          currentStaff.addAll(updatedData);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<ReceptionistStaffProvider>(context);

    final staffName = currentStaff['staffName']?.toString() ?? 'No Name';
    final staffRole = currentStaff['staffRole']?.toString() ?? '';
    final staffExperience =
        currentStaff['staffExperience']?.toString() ?? 'N/A';
    final staffContact = currentStaff['staffContactNumber']?.toString() ?? '';
    final staffEmail = currentStaff['staffEmail']?.toString() ?? '';
    final staffAbout = currentStaff['about']?.toString() ?? '';
    final createdAt = currentStaff['createdAt']?.toString();
    final avatar = currentStaff['avatar']?.toString();

    return Scaffold(
      backgroundColor: AppColors.sky_blue_bg,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.sky_blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.person_outline,
                color: AppColors.sky_blue,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text("Employee Profile"),
          ],
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.text_dark,
        elevation: 2,
        shadowColor: AppColors.black.withOpacity(0.1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.text_dark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile(screenWidth) ? 16 : 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(
                  screenWidth,
                  avatar,
                  staffName,
                  staffRole,
                  staffContact,
                  staffEmail,
                ),
                const SizedBox(height: 24),
                _buildInfoCards(screenWidth, staffExperience, createdAt),
                const SizedBox(height: 24),
                if (currentStaff['skills'] != null &&
                    (currentStaff['skills'] as List).isNotEmpty)
                  _buildSkillsSection(currentStaff['skills']),
                if (staffAbout.isNotEmpty) _buildAboutSection(staffAbout),
                _buildActionButtons(screenWidth, provider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // (Include all your existing _buildProfileHeader, _buildAvatar, _buildProfileInfo, _buildContactRow, _buildInfoCards, _infoCard, _buildSkillsSection, _buildAboutSection methods here exactly as they were...)

  Widget _buildProfileHeader(
    double screenWidth,
    String? avatar,
    String staffName,
    String staffRole,
    String staffContact,
    String staffEmail,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile(screenWidth) ? 20 : 28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child:
          isMobile(screenWidth)
              ? Column(
                children: [
                  _buildAvatar(avatar),
                  const SizedBox(height: 20),
                  _buildProfileInfo(
                    staffName,
                    staffRole,
                    staffContact,
                    staffEmail,
                  ),
                ],
              )
              : Row(
                children: [
                  _buildAvatar(avatar),
                  const SizedBox(width: 32),
                  Expanded(
                    child: _buildProfileInfo(
                      staffName,
                      staffRole,
                      staffContact,
                      staffEmail,
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildAvatar(String? avatar) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.sky_blue, width: 4),
        boxShadow: [
          BoxShadow(
            color: AppColors.sky_blue.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundImage:
            (avatar != null &&
                    avatar.isNotEmpty &&
                    Uri.tryParse(avatar)?.hasAbsolutePath == true)
                ? NetworkImage(avatar)
                : const AssetImage('assets/general_icons/employee.png')
                    as ImageProvider,
        backgroundColor: AppColors.sky_blue.withOpacity(0.1),
      ),
    );
  }

  Widget _buildProfileInfo(
    String staffName,
    String staffRole,
    String staffContact,
    String staffEmail,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          staffName,
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
            color: AppColors.sky_blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.sky_blue.withOpacity(0.3)),
          ),
          child: Text(
            staffRole,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.sky_blue,
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (staffContact.isNotEmpty)
          _buildContactRow(Icons.phone_outlined, staffContact),
        if (staffEmail.isNotEmpty)
          _buildContactRow(Icons.email_outlined, staffEmail),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.sky_blue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: AppColors.text_grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards(
    double screenWidth,
    String experience,
    String? createdAt,
  ) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        _infoCard(
          "Experience",
          experience,
          Icons.work_outline_rounded,
          AppColors.sky_blue,
        ),
        _infoCard(
          "Joined",
          (createdAt != null && createdAt.isNotEmpty)
              ? createdAt.substring(0, 10)
              : 'N/A',
          Icons.calendar_today_outlined,
          AppColors.status_completed,
        ),
      ],
    );
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 220,
      height: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text_dark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.text_grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(List skills) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            spreadRadius: 2,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.sky_blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.star_outline_rounded,
                  color: AppColors.sky_blue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Skills",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
              skills.map(
                (skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.sky_blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.sky_blue.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    skill.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.sky_blue,
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

  Widget _buildAboutSection(String staffAbout) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            spreadRadius: 2,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.sky_blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.sky_blue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "About",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text_dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            staffAbout,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: AppColors.text_grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    double screenWidth,
    ReceptionistStaffProvider provider,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child:
          isMobile(screenWidth)
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildEditButton(),
                  const SizedBox(height: 12),
                  _buildDeleteButton(provider),
                ],
              )
              : Row(
                children: [
                  Expanded(child: _buildEditButton()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDeleteButton(provider)),
                ],
              ),
    );
  }

  Widget _buildEditButton() {
    return Container(
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
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => editEmployeeInformation(context),
        icon: Icon(Icons.edit_outlined, color: AppColors.white, size: 20),
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

  Widget _buildDeleteButton(ReceptionistStaffProvider provider) {
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
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed:
            provider.isLoading
                ? null
                : () async {
                  final confirm = await _showDeleteConfirmation();
                  if (confirm == true) {
                    bool success = await provider.deleteStaff(
                      context,
                      currentStaff['_id'].toString(),
                    );
                    if (success && mounted) Navigator.pop(context);
                  }
                },
        icon:
            provider.isLoading
                ? const SizedBox()
                : Icon(Icons.delete_outline, color: AppColors.white, size: 20),
        label:
            provider.isLoading
                ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : Text(
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

  Future<bool?> _showDeleteConfirmation() {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
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
                Text(
                  "Confirm Deletion",
                  style: TextStyle(
                    color: AppColors.text_dark,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            content: Text(
              "Are you sure you want to remove this employee? This action cannot be undone.",
              style: TextStyle(color: AppColors.text_dark, fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
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
                  onPressed: () => Navigator.pop(context, true),
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
