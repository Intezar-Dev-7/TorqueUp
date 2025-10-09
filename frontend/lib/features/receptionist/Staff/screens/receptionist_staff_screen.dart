import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/features/receptionist/Staff/widgets/add_staff_form.dart';
import 'package:frontend/features/receptionist/Staff/widgets/interns_widget.dart';
import 'package:frontend/features/receptionist/Staff/widgets/mechanics.widget.dart';
import 'package:frontend/features/receptionist/Staff/widgets/otherEmployee_widget.dart';

class ReceptionistStaffScreen extends StatefulWidget {
  const ReceptionistStaffScreen({super.key});

  @override
  State<ReceptionistStaffScreen> createState() =>
      _ReceptionistStaffScreenState();
}

class _ReceptionistStaffScreenState extends State<ReceptionistStaffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: "Staff",
        subtitle: 'Edit, Update and Delete employees',
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddStaff(), // your custom dialog widget
          );
        },
        text: 'Add Satff',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // mechanics widget
            Mechanics(),

            SizedBox(width: 20),
            // interns widget
            Interns(),
            SizedBox(width: 20),
            // Other employees widget
            OtherEmployees(),
          ],
        ),
      ),
    );
  }
}
