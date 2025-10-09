import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Staff/screens/staff_profile_screen.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';
import 'package:frontend/utils/colors.dart';

class InternsWidget extends StatefulWidget {
  const InternsWidget({super.key});

  @override
  State<InternsWidget> createState() => _InternsWidgetState();
}

class _InternsWidgetState extends State<InternsWidget> {
  final receptionistStaffServices = ReceptionistStaffServices();
  List<Map<String, dynamic>> interns = [];

  @override
  void initState() {
    super.initState();
    loadStaff();
  }

  void loadStaff() async {
    final staffService = ReceptionistStaffServices();
    interns = await staffService.getStaffByRole(
      context: context,
      staffRole: 'Intern',
    );
    print('Fetched interns: $interns');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Interns",
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
            itemCount: interns.length,
            itemBuilder: (context, i) {
              final intern = interns[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      intern['avatar'] != null && intern['avatar'].isNotEmpty
                          ? NetworkImage(intern['avatar'])
                          : AssetImage('assets/general_icons/employee.png')
                              as ImageProvider,
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                ),
                title: Text(intern['staffName']),
                subtitle: Text(intern['staffRole']),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaffProfileScreen(staff: intern),
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
