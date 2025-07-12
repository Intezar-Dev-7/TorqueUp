import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/features/admin/Mechanics/widgets/interns.dart';
import 'package:frontend/features/admin/Mechanics/widgets/mechanics.dart';
import 'package:frontend/features/admin/Mechanics/widgets/other_employees.dart';
import 'package:frontend/utils/data/dummy_data.dart';

class MechanicsScreen extends StatefulWidget {
  const MechanicsScreen({super.key});

  @override
  State<MechanicsScreen> createState() => _MechanicsScreenState();
}

class _MechanicsScreenState extends State<MechanicsScreen> {
  @override
  Widget build(BuildContext context) {
    final mechanics = Employees.mechanicsData;
    final interns = Employees.internsData;
    final otherEmployees = Employees.otherEmployees;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: "Staff", subtitle: 'Manage your employees'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // mechanics widget
            MechanicsWidget(mechanics: mechanics),

            SizedBox(width: 20),
            // interns widget
            InternsWidget(interns: interns),
            SizedBox(width: 20),
            // Other employees widget
            OtherEmployeesWidget(otherEmployees: otherEmployees),
          ],
        ),
      ),
    );
  }
}
