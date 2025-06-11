import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/data/dummy_data.dart';
import 'package:frontend/utils/colors.dart';

class MechanicsAvailabilityWidget extends StatefulWidget {
  const MechanicsAvailabilityWidget({super.key});

  @override
  State<MechanicsAvailabilityWidget> createState() =>
      _MechanicsAvailabilityWidgetState();
}

class _MechanicsAvailabilityWidgetState
    extends State<MechanicsAvailabilityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 265,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
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
                  "assets/SideNavigaionBarIcons/mechanic.png",
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
                        mechanic_availability_data
                            .take(3)
                            .map(
                              (mechanic) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      mechanic['serial_no'].toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mechanic['name'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mechanic['status'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mechanic['Vehicle'].isEmpty
                                          ? '- - - - - - - - '
                                          : mechanic['Vehicle'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mechanic['time_slot'].isEmpty
                                          ? '- - - - - - - - - - - - -'
                                          : mechanic['time_slot'],
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
