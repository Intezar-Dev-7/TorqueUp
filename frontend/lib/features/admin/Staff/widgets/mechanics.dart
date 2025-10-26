import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Staff/screens/employees_profile_screen.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';
import 'package:frontend/utils/colors.dart';

class MechanicsWidget extends StatefulWidget {
  const MechanicsWidget({super.key});

  @override
  State<MechanicsWidget> createState() => _MechanicsWidgetState();
}

class _MechanicsWidgetState extends State<MechanicsWidget> {
  List<Map<String, dynamic>> mechanics = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStaff();
  }

  void loadStaff() async {
    setState(() => isLoading = true);
    final staffService = ReceptionistStaffServices();
    mechanics = await staffService.getStaffByRole(
      context: context,
      staffRole: 'Mechanic',
    );
    print('Fetched mechanics: $mechanics');
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.admin_primary.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.admin_primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.build_outlined,
                    color: AppColors.admin_primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Mechanics",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.admin_primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.admin_primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    mechanics.length.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 500,
            child: isLoading
                ? Center(
              child: CircularProgressIndicator(
                color: AppColors.admin_primary,
              ),
            )
                : mechanics.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.build_outlined,
                    size: 48,
                    color: AppColors.text_grey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No mechanics found',
                    style: TextStyle(
                      color: AppColors.text_grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: mechanics.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: AppColors.border_grey.withOpacity(0.3),
              ),
              itemBuilder: (context, i) {
                final mechanic = mechanics[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.admin_primary.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: mechanic['avatar'] != null &&
                              mechanic['avatar'].isNotEmpty
                              ? NetworkImage(mechanic['avatar'])
                              : const AssetImage(
                              'assets/general_icons/employee.png')
                          as ImageProvider,
                          radius: 28,
                          backgroundColor: AppColors.admin_primary.withOpacity(0.1),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mechanic['staffName'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.text_dark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mechanic['staffRole'],
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.text_grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.admin_primary,
                              AppColors.admin_primary_light,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmployeesProfileScreen(staff: mechanic),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
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
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
