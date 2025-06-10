import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Dashboard/widgets/inventory_status_alert_table.dart';
import 'package:frontend/features/receptionist/Dashboard/widgets/mechanics_availability_table.dart';
import 'package:frontend/features/receptionist/Dashboard/widgets/todays_appointment_table.dart';
import 'package:frontend/utils/colors.dart';

class DashboardTables extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1000;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child:
            !isMobile
                ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: MechanicsAvailabilityTable(),
                          ),
                          SizedBox(height: 16),
                          Expanded(flex: 1, child: InventoryStatusTable()),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(flex: 1, child: TodaysAppointmentsTable()),
                  ],
                )
                : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: MechanicsAvailabilityTable(),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: TodaysAppointmentsTable(),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: InventoryStatusTable(),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
