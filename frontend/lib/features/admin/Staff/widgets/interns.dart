import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Staff/screens/employees_profile_screen.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';
import 'package:frontend/utils/colors.dart';

class InternsWidget extends StatefulWidget {
  const InternsWidget({super.key});

  @override
  State<InternsWidget> createState() => _InternsWidgetState();
}

class _InternsWidgetState extends State<InternsWidget> {
  List<Map<String, dynamic>> interns = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStaff();
  }

  void loadStaff() async {
    setState(() => isLoading = true);
    final staffService = ReceptionistStaffServices();
    interns = await staffService.getStaffByRole(
      context: context,
      staffRole: 'Intern',
    );
    print('Fetched interns: $interns');
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
              color: AppColors.status_pending.withOpacity(0.08),
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
                    color: AppColors.status_pending.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    color: AppColors.status_pending,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Interns",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.status_pending,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.status_pending,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    interns.length.toString(),
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
                color: AppColors.status_pending,
              ),
            )
                : interns.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: 48,
                    color: AppColors.text_grey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No interns found',
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
              itemCount: interns.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: AppColors.border_grey.withOpacity(0.3),
              ),
              itemBuilder: (context, i) {
                final intern = interns[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.status_pending.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: intern['avatar'] != null &&
                              intern['avatar'].isNotEmpty
                              ? NetworkImage(intern['avatar'])
                              : const AssetImage(
                              'assets/general_icons/employee.png')
                          as ImageProvider,
                          radius: 28,
                          backgroundColor: AppColors.status_pending.withOpacity(0.1),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              intern['staffName'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.text_dark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              intern['staffRole'],
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
                          color: AppColors.status_pending,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmployeesProfileScreen(staff: intern),
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
