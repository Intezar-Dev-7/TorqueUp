import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/data/dummy_data.dart';

class MechanicsAvailabilityWidget extends StatelessWidget {
  const MechanicsAvailabilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 266,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/sidebar_nav_icons/mechanic.png",
                  width: 25,
                ),
                SizedBox(width: 8),
                const Text(
                  "Mechanics Availability",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See All",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTableTheme(
                  data: DataTableThemeData(
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    dataRowMinHeight: 30, // ↓ default is 56, reduce as needed
                    dataRowMaxHeight:
                        40, // ↓ make both min and max same for compact rows
                  ),
                  child: DataTable(
                    columnSpacing:
                        45, // optional: reduce horizontal spacing too
                    columns: const [
                      DataColumn(
                        label: Text('S. No', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text('Mechanic', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text('Status', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text('Vehicle', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text(
                          'Time Slot',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                    rows:
                        mechanics
                            .take(3)
                            .map(
                              (mechanic) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      mechanic.serialNo,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mechanic.name,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mechanic.status,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mechanic.workOnVehicle.isEmpty
                                          ? '- - - - - - - - '
                                          : mechanic.workOnVehicle,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mechanic.timeSlot.isEmpty
                                          ? '- - - - - - - - - - - - -'
                                          : mechanic.timeSlot,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
