import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';
import 'package:frontend/features/receptionist/Staff/widgets/edit_employee_info.dart';
import 'package:frontend/features/receptionist/model/staff_model.dart';
import 'package:frontend/utils/colors.dart';

class StaffProfileScreen extends StatefulWidget {
  final Map<String, dynamic> staff;
  const StaffProfileScreen({super.key, required this.staff});

  @override
  State<StaffProfileScreen> createState() => _StaffProfileScreenState();
}

class _StaffProfileScreenState extends State<StaffProfileScreen> {
  final staffService = ReceptionistStaffServices();
  List<Staff> staffList = [];
  bool isLoading = true;
  void deleteEmployeeById(String staffId) async {
    await staffService.deleteEmployee(context: context, staffId: staffId);
    setState(() {
      staffList.removeWhere((staff) => staff.staffId == staffId);
    });
  }

  void editEmployeeInformation(
    BuildContext context, {
    required String staffId,
    required String staffName,
    required String staffRole,
    required String staffExperience,
    required String staffContactNumber,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.7,
            child: EditEmployeeInfoWidget(
              staffId: staffId,
              staffName: staffName,
              staffRole: staffRole,
              staffExperience: staffExperience,
              staffContactNumber: staffContactNumber,
            ),
          ),
        );
      },
    ).then((_) {
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final staff = widget.staff;

    // ✅ Safe value conversions
    final staffName = staff['staffName']?.toString() ?? 'No Name';
    final staffRole = staff['staffRole']?.toString() ?? '';
    final staffExperience = staff['staffExperience']?.toString() ?? 'N/A';
    final staffContact = staff['staffContactNumber']?.toString() ?? '';
    final staffSkills = staff['staffSkills']?.toString() ?? '';
    final staffEmail = staff['staffEmail']?.toString() ?? '';
    final staffAbout = staff['about']?.toString() ?? '';
    final createdAt = staff['createdAt']?.toString();
    final avatar = staff['avatar']?.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🧍 Profile Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          (avatar != null &&
                                  avatar.isNotEmpty &&
                                  Uri.tryParse(avatar)?.hasAbsolutePath == true)
                              ? NetworkImage(avatar)
                              : const AssetImage(
                                    'assets/general_icons/employee.png',
                                  )
                                  as ImageProvider,
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staffName,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          staffRole,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (staffContact.isNotEmpty)
                          Text(
                            staffContact,
                            style: const TextStyle(fontSize: 15),
                          ),
                        if (staffEmail.isNotEmpty)
                          Text(
                            staffEmail,
                            style: const TextStyle(fontSize: 15),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // 📊 Info Cards
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _infoCard("Experience", staffExperience),
                    _infoCard(
                      "Joined",
                      (createdAt != null && createdAt.isNotEmpty)
                          ? createdAt.substring(0, 10)
                          : 'N/A',
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // 🧠 Skills / Tags
                if (staff['skills'] != null && staff['skills'] is List)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staffSkills,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: List<Widget>.from(
                          (staff['skills'] as List).map(
                            (skill) => Chip(
                              label: Text(
                                skill.toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),

                // 🧾 About Section
                if (staffAbout.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "About",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(staffAbout, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 32),
                    ],
                  ),

                // 🧰 Action Buttons
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                      ),
                      onPressed:
                          () => editEmployeeInformation(
                            context,
                            staffId: staff['_id'],
                            staffName: staffName,
                            staffRole: staffRole,
                            staffExperience: staffExperience,
                            staffContactNumber: staffContact,
                          ),
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                      ),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text("Confirm Deletion"),
                                content: const Text(
                                  "Are you sure you want to remove this employee?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, true),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                        );

                        if (confirm == true) {
                          deleteEmployeeById(staff['_id'].toString());
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Remove Employee",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Card widget for info display
  Widget _infoCard(String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 200,
        height: 100,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
