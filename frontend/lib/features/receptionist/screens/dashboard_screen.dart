import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/widgets/dash_info_card.dart';
import 'package:frontend/features/receptionist/widgets/dashboard_tables.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/constant.dart';

import '../data/dummy_data.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // final bool isMobile = screenWidth < 600; // Phone
    // final bool isTablet = screenWidth >= 600 && screenWidth < 1024; // Tablet
    // final bool isDesktop = screenWidth >= 1024; // Desktop

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;

                if (width < 600) {
                  // 📱 Mobile view: grid (2x2 or 4x1)
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 4,
                    childAspectRatio: 2.2,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        top_widget_data.map((item) {
                          return DashInfoCard(
                            icon: item['icon'],
                            title: item['title'],
                            value: item['value'],
                            iconSize: 22,
                            titleSize: 12,
                            valueSize: 20,
                          );
                        }).toList(),
                  );
                } else if (width >= 600 && width < 1024) {
                  // 📱 Tablet view: horizontal scroll if width is tight
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: top_widget_data.length,
                      itemBuilder: (_, index) {
                        var item = top_widget_data[index];
                        return DashInfoCard(
                          icon: item['icon'],
                          title: item['title'],
                          value: item['value'],
                        );
                      },
                    ),
                  );
                } else {
                  // 🖥️ Desktop view: default layout in a row
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                        top_widget_data.map((item) {
                          return DashInfoCard(
                            icon: item['icon'],
                            title: item['title'],
                            value: item['value'],
                          );
                        }).toList(),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            dashcode(),
          ],
        ),
      ),
    );
  }

  Row dashcode() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'Mechanic Availability',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.grey,
                    ),
                    headingTextStyle: TextStyle(color: AppColors.black),
                    columns: const [
                      DataColumn(label: Text('S. No')),
                      DataColumn(label: Text('Mechanic')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Vehicle')),
                      DataColumn(label: Text('Time Slot')),
                    ],
                    rows:
                        mechanic_availability_data
                            .map(
                              (mechanic) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(mechanic['serial_no'].toString()),
                                  ),
                                  DataCell(Text(mechanic['name'])),
                                  DataCell(Text(mechanic['status'])),
                                  DataCell(
                                    Text(
                                      mechanic['Vehicle'].isEmpty
                                          ? '- - - - - - - - '
                                          : mechanic['Vehicle'],
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      mechanic['time_slot'].isEmpty
                                          ? '- - - - - - - - - - - - -'
                                          : mechanic['time_slot'],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Inventory status alert',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.grey,
                    ),
                    headingTextStyle: TextStyle(color: AppColors.black),
                    columns: const [
                      DataColumn(label: Text('S. No')),
                      DataColumn(label: Text('Product')),
                      DataColumn(label: Text('Available Q.')),
                      DataColumn(label: Text('Modify Q.')),
                      DataColumn(label: Text('Add')),
                    ],
                    rows:
                        inventory_item
                            .map(
                              (item) => DataRow(
                                cells: [
                                  DataCell(Text(item['serial_no'].toString())),
                                  DataCell(
                                    Row(
                                      children: [
                                        Image.asset(
                                          item['image'].toString(),
                                          width: 30,
                                          height: 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(item['name'].toString()),
                                            Text(
                                              item['desc'].toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text(item['available'].toString())),
                                  DataCell(
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: Image.asset(
                                            GenIcons.remove,
                                            width: 24,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          '5',
                                          style: TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        TextButton(
                                          onPressed: () {},
                                          child: Image.asset(
                                            GenIcons.add,
                                            width: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text('add'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Inventory status alert',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.grey,
                    ),
                    headingTextStyle: TextStyle(color: AppColors.black),
                    columns: const [
                      DataColumn(label: Text('S. No')),
                      DataColumn(label: Text('Vehicle')),
                      DataColumn(label: Text('Owner')),
                      DataColumn(label: Text('Work')),
                      DataColumn(label: Text('Time Slot')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows:
                        appointments
                            .map(
                              (appt) => DataRow(
                                cells: [
                                  DataCell(Text(appt["sno"])),
                                  DataCell(
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(appt["vehicle"]),
                                        Text(
                                          appt["number"],
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text(appt["owner"])),
                                  DataCell(Text(appt["work"])),
                                  DataCell(Text(appt["slot"])),
                                  DataCell(
                                    Icon(
                                      appt["status"] == "done"
                                          ? Icons.check_circle
                                          : Icons.access_time,
                                      color:
                                          appt["status"] == "done"
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
            ],
          ),
        ),
      ],
    );
  }
}
