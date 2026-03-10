import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Staff/screens/employees_profile_screen.dart';
import 'package:frontend/features/receptionist/data/provider/receptionist_staff_provider.dart';
import 'package:frontend/utils/colors.dart';
import 'package:provider/provider.dart';

class OtherEmployeesWidget extends StatelessWidget {
  const OtherEmployeesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReceptionistStaffProvider>(context);
    final otherEmployees = provider.otherEmployees;

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
              color: AppColors.status_completed.withOpacity(0.08),
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
                    color: AppColors.status_completed.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: AppColors.status_completed,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Other Employees",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.status_completed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.status_completed,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    otherEmployees.length.toString(),
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
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator(color: AppColors.status_completed))
                : otherEmployees.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline, size: 48, color: AppColors.text_grey.withOpacity(0.5)),
                  const SizedBox(height: 12),
                  Text('No other employees found', style: TextStyle(color: AppColors.text_grey, fontSize: 14)),
                ],
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: otherEmployees.length,
              separatorBuilder: (context, index) => Divider(height: 1, color: AppColors.border_grey.withOpacity(0.3)),
              itemBuilder: (context, i) {
                final employee = otherEmployees[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.status_completed.withOpacity(0.3), width: 2),
                        ),
                        child: CircleAvatar(
                          backgroundImage: employee['avatar'] != null && employee['avatar'].isNotEmpty
                              ? NetworkImage(employee['avatar'])
                              : const AssetImage('assets/general_icons/employee.png') as ImageProvider,
                          radius: 28,
                          backgroundColor: AppColors.status_completed.withOpacity(0.1),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(employee['staffName'] ?? 'No Name', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.text_dark)),
                            const SizedBox(height: 4),
                            Text(employee['staffRole'] ?? '', style: TextStyle(fontSize: 13, color: AppColors.text_grey)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.status_completed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeesProfileScreen(staff: employee)));
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                          child: Text('View', style: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w600)),
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