import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Mechanics/screens/employees_profile_screen.dart';
import 'package:frontend/utils/colors.dart';

class MechanicsWidget extends StatelessWidget {
  const MechanicsWidget({super.key, required this.mechanics});

  final List<Map<String, dynamic>> mechanics;

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
          height: 600,
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
                  backgroundImage: NetworkImage(mechanic['avatar']),

                  radius: 24,
                  backgroundColor: Colors.grey[200],
                ),
                title: Text(mechanic['name']),
                subtitle: Text(mechanic['role']),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeesProfileScreen(),
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
