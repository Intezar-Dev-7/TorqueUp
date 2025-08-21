import 'package:flutter/material.dart';
import 'package:frontend/features/admin/Staff/screens/employees_profile_screen.dart';
import 'package:frontend/utils/colors.dart';

class InternsWidget extends StatelessWidget {
  const InternsWidget({super.key, required this.interns});

  final List<Map<String, dynamic>> interns;

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
                  backgroundImage: NetworkImage(intern['avatar']),
                ),
                title: Text(intern['name']),
                subtitle: Text(intern['role']),
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
