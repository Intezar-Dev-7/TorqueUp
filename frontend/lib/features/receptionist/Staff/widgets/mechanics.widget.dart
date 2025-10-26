import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Staff/screens/staff_profile_screen.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';
import 'package:frontend/utils/colors.dart';

class Mechanics extends StatefulWidget {
  const Mechanics({super.key});

  @override
  State<Mechanics> createState() => _MechanicsState();
}

class _MechanicsState extends State<Mechanics> {
  final staffService = ReceptionistStaffServices();
  List<Map<String, dynamic>> mechanics = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStaff();
  }

  void loadStaff() async {
    setState(() => isLoading = true);
    mechanics = await staffService.getStaffByRole(
      context: context,
      staffRole: 'Mechanic',
    );

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.sky_blue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Mechanics",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.text_dark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 500,
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
          child:
              isLoading
                  ? Center(
                    child: CircularProgressIndicator(color: AppColors.sky_blue),
                  )
                  : mechanics.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.engineering_outlined,
                          size: 64,
                          color: AppColors.text_grey.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No mechanics found',
                          style: TextStyle(
                            color: AppColors.text_grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                  : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: mechanics.length,
                    separatorBuilder:
                        (context, index) => Divider(
                          height: 1,
                          color: AppColors.border_grey.withOpacity(0.3),
                        ),
                    itemBuilder: (context, i) {
                      final mechanic = mechanics[i];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.sky_blue.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                mechanic['avatar'] != null &&
                                        mechanic['avatar'].isNotEmpty
                                    ? NetworkImage(mechanic['avatar'])
                                    : const AssetImage(
                                          'assets/general_icons/employee.png',
                                        )
                                        as ImageProvider,
                            radius: 24,
                            backgroundColor: AppColors.sky_blue.withOpacity(
                              0.1,
                            ),
                          ),
                        ),
                        title: Text(
                          mechanic['staffName'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.text_dark,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          mechanic['staffRole'],
                          style: TextStyle(
                            color: AppColors.text_grey,
                            fontSize: 13,
                          ),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.sky_blue,
                                AppColors.sky_blue_light,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.sky_blue.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          StaffProfileScreen(staff: mechanic),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.transparent,
                              shadowColor: AppColors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'View',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
