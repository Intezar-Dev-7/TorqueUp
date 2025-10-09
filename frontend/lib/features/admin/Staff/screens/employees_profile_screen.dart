import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final staff = widget.staff;

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
                // Profile Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          staff['avatar'] != null && staff['avatar'].isNotEmpty
                              ? NetworkImage(staff['avatar'])
                              : const AssetImage(
                                    'assets/general_icons/employee.png',
                                  )
                                  as ImageProvider,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staff['staffName'] ?? 'No Name',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          staff['staffRole'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (staff['staffContactNumber'] != null)
                          Text(staff['staffContactNumber']),
                        if (staff['staffEmail'] != null)
                          Text(staff['staffEmail']),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Info Cards
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _infoCard("Experience", staff['staffExperience'] ?? 'N/A'),

                    _infoCard(
                      "Joined",
                      staff['createdAt'] != null
                          ? staff['createdAt'].substring(0, 10)
                          : 'N/A',
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Skills/Tags
                if (staff['skills'] != null && staff['skills'] is List)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Skills",
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
                            (skill) => Chip(label: Text(skill)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),

                // About Section
                if (staff['about'] != null)
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
                      Text(
                        staff['about'],
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),

                // Action Buttons
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                      ),
                      onPressed: () {
                        // Handle edit
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                      ),
                      onPressed: () {
                        staffService.deleteEmployee(
                          context: context,
                          staffId: staff['_id'],
                        );
                        Navigator.pop(context);
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
