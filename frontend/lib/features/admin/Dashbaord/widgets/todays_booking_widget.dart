import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/data/dummy_data.dart';

class TodaysBookingWidget extends StatefulWidget {
  const TodaysBookingWidget({super.key});

  @override
  State<TodaysBookingWidget> createState() => _TodaysBookingWidgetState();
}

class _TodaysBookingWidgetState extends State<TodaysBookingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 266,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.green,
                    size: 16,
                  ),
                ),
                SizedBox(width: 8),
                const Text(
                  "Today's Booking",
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
                    dataRowMinHeight: 45, // ↓ default is 56, reduce as needed
                    dataRowMaxHeight:
                        45, // ↓ make both min and max same for compact rows
                  ),
                  child: DataTable(
                    columnSpacing:
                        45, // optional: reduce horizontal spacing too
                    columns: const [
                      DataColumn(
                        label: Text('S. No', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text('Vehicle', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text('Owner', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text('Work', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text('B.Time', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text('Status', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                    rows:
                        appointments
                            .take(3)
                            .map(
                              (appt) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      appt.serialNo,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          appt.vehicle,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          appt.vehicle,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      appt.owner,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      appt.work,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      appt.timeSlot,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Icon(
                                      appt.status == "done"
                                          ? Icons.check_circle
                                          : Icons.access_time,
                                      color:
                                          appt.status == "done"
                                              ? Colors.green
                                              : Colors.orange,
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
