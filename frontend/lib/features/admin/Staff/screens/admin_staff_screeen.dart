import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/features/admin/Staff/widgets/interns.dart';
import 'package:frontend/features/admin/Staff/widgets/mechanics.dart';
import 'package:frontend/features/admin/Staff/widgets/other_employees.dart';

class AdminStaffScreen extends StatefulWidget {
  const AdminStaffScreen({super.key});

  @override
  State<AdminStaffScreen> createState() => _AdminStaffScreenState();
}

class _AdminStaffScreenState extends State<AdminStaffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: "Staff",
        subtitle: 'Manage your employees',
        onPressed: () {},
        text: '',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // mechanics widget
            MechanicsWidget(),

            SizedBox(width: 20),
            // interns widget
            InternsWidget(),
            SizedBox(width: 20),
            // Other employees widget
            OtherEmployeesWidget(),
          ],
        ),
      ),
    );
  }
}
