import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Dashboard/widgets/inventory_status_alert_table.dart';
import 'package:frontend/features/receptionist/Dashboard/widgets/mechanics_availability_table.dart';
import 'package:frontend/features/receptionist/Dashboard/widgets/todays_appointment_table.dart';
import 'package:frontend/utils/colors.dart';

class DashboardTables extends StatefulWidget {
  const DashboardTables({super.key});

  @override
  State<DashboardTables> createState() => _DashboardTablesState();
}

class _DashboardTablesState extends State<DashboardTables> {
  int selectedIndex = 0;
  final List<Widget> tableList = [
    MechanicsAvailabilityTable(),
    TodaysAppointmentsTable(),
    InventoryStatusTable(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isCompact = screenWidth < 1000;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child:
            !isCompact
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
                : Column(
                  children: [
                    Expanded(child: tableList[selectedIndex]),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex =
                                    (selectedIndex - 1) % tableList.length;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.grey30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex =
                                    (selectedIndex + 1) % tableList.length;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.grey30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
