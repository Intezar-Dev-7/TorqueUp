import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Staff/screens/staff_profile_screen.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';
import 'package:frontend/utils/colors.dart';

class OtherEmployees extends StatefulWidget {
  const OtherEmployees({super.key});

  @override
  State<OtherEmployees> createState() => _OtherEmployeesState();
}

class _OtherEmployeesState extends State<OtherEmployees> {
  List<Map<String, dynamic>> otherEmployees = [];
  @override
  void initState() {
    super.initState();
    loadStaff();
  }

  void loadStaff() async {
    final staffService = ReceptionistStaffServices();
    otherEmployees = await staffService.getStaffByRole(
      context: context,
      staffRole: 'otherEmployee',
    );
    print('Fetched other employees: $otherEmployees');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Other Employees",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          // textAlign: TextAlign.left,
        ),
        Container(
          width: 380,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListView.builder(
            itemCount: otherEmployees.length,
            itemBuilder: (context, i) {
              final otherEmployee = otherEmployees[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      otherEmployee['avatar'] != null &&
                              otherEmployee['avatar'].isNotEmpty
                          ? NetworkImage(otherEmployee['avatar'])
                          : AssetImage('assets/general_icons/employee.png')
                              as ImageProvider,

                  radius: 24,
                  backgroundColor: Colors.grey[200],
                ),
                title: Text(otherEmployee['staffName']),
                subtitle: Text(otherEmployee['staffRole']),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                StaffProfileScreen(staff: otherEmployee),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppColors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(color: Colors.white, fontSize: 15),
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
