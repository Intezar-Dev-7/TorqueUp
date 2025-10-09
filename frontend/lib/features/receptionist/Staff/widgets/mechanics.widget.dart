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
  @override
  void initState() {
    super.initState();
    loadStaff();
  }

  void loadStaff() async {
    mechanics = await staffService.getStaffByRole(
      context: context,
      staffRole: 'Mechanic',
    );
    print('Fetched mechanics: $mechanics');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mechanics",
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
            itemCount: mechanics.length,
            itemBuilder: (context, i) {
              final mechanic = mechanics[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      mechanic['avatar'] != null &&
                              mechanic['avatar'].isNotEmpty
                          ? NetworkImage(mechanic['avatar'])
                          : AssetImage('assets/general_icons/employee.png')
                              as ImageProvider,

                  radius: 24,
                  backgroundColor: Colors.grey[200],
                ),
                title: Text(mechanic['staffName']),
                subtitle: Text(mechanic['staffRole']),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => StaffProfileScreen(staff: mechanic),
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
