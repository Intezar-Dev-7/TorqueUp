import 'package:flutter/material.dart';

class DashboardTables extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isMobile ? _buildMobileView() : _buildTabletDesktopView(),
    );
  }

  Widget _buildMobileView() {
    return Column(
      children: [
        _mechanicAvailabilityCard(),
        SizedBox(height: 16),
        _appointmentCard(),
      ],
    );
  }

  Widget _buildTabletDesktopView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _mechanicAvailabilityCard()),
        SizedBox(width: 16),
        Expanded(flex: 2, child: _appointmentCard()),
      ],
    );
  }

  Widget _mechanicAvailabilityCard() {
    final List<List<String>> data = [
      ['01', 'Mechanic one', 'Working', 'MP05 MV6802', '10:30AM - 12:30PM'],
      ['01', 'Mechanic one', 'Idle', '-', '-'],
      ['01', 'Mechanic one', 'Working', 'MP05 MV6802', '10:30AM - 12:30PM'],
      ['01', 'Mechanic one', 'Idle', '-', '-'],
      ['01', 'Mechanic one', 'Working', 'MP05 MV6802', '10:30AM - 12:30PM'],
    ];

    return Card(
      elevation: 4,
      child: Column(
        children: [
          _buildHeader('Mechanics Availability', icon: Icons.engineering),
          DataTable(
            columnSpacing: 8,
            headingRowHeight: 30,
            dataRowHeight: 40,
            columns: ['S. No', 'Name', 'Status', 'Work on v.', 'Time Slot']
                .map((e) => DataColumn(label: Text(e)))
                .toList(),
            rows: data
                .map(
                  (row) => DataRow(
                cells: row.map((cell) => DataCell(Text(cell))).toList(),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _appointmentCard() {
    final List<List<String>> data = [
      ['01', 'Tata Safari', 'Raja Ram..', 'Gen. Serv.', '10-11', 'done'],
      ['02', 'Tata Curvv', 'Hemant s..', 'Repairing.', '11-1', 'pending'],
      ['03', 'CT 100 ES', 'Hemant s..', 'Gen. Serv.', '1-2', 'pending'],
      ['04', 'Shine 125', 'Bhupendr..', 'Gen. Serv.', '2-3', 'done'],
      ['05', 'Tata Safari', 'Raja Ram..', 'Gen. Serv.', '3-4', 'done'],
      ['06', 'Tata Curvv', 'Hemant s..', 'Repairing.', '4-6', 'pending'],
      ['07', 'CT 100 ES', 'Hemant s..', 'Gen. Serv.', '6-7', 'pending'],
      ['08', 'Tata Safari', 'Raja Ram..', 'Gen. Serv.', '7-8', 'done'],
      ['09', 'Tata Curvv', 'Hemant s..', 'Repairing.', '8-10', 'pending'],
      ['10', 'CT 100 ES', 'Hemant s..', 'Gen. Serv.', '10-11', 'pending'],
      ['11', 'Shine 125', 'Bhupendr..', 'Gen. Serv.', 'Tom.', 'pending'],
    ];

    return Card(
      elevation: 4,
      child: Column(
        children: [
          _buildHeader('Today\'s Appointments', icon: Icons.calendar_today),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 12,
              headingRowHeight: 30,
              dataRowHeight: 40,
              columns: ['S. No', 'Vehicle', 'Owner', 'Work', 'Time Slot', 'Status']
                  .map((e) => DataColumn(label: Text(e)))
                  .toList(),
              rows: data.map((row) {
                return DataRow(cells: [
                  for (int i = 0; i < row.length; i++)
                    if (i == 5)
                      DataCell(Icon(
                        row[i] == 'done'
                            ? Icons.check_circle
                            : Icons.access_time,
                        color: row[i] == 'done' ? Colors.green : Colors.orange,
                      ))
                    else
                      DataCell(Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(row[i], maxLines: 1, overflow: TextOverflow.ellipsis),
                          if (i == 1)
                            Text("MP05MV6802",
                                style: TextStyle(fontSize: 10, color: Colors.grey))
                        ],
                      )),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, {required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
          Text('See all', style: TextStyle(color: Colors.blue, fontSize: 12))
        ],
      ),
    );
  }
}
