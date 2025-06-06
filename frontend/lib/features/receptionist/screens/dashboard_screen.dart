import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/widgets/dash_top_widget.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/constant.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final List<dynamic> top_widget_data = [
    {'icon': GenIcons.money, 'title': 'Revenue', 'value': 5320},
    {'icon': ServiceIcons.inProgress, 'title': 'Active Services', 'value': 5},
    {
      'icon': ServiceIcons.completed,
      'title': 'Completed Services',
      'value': 16,
    },
    {
      'icon': ServiceIcons.scheduled,
      'title': 'Scheduled Services',
      'value': 14,
    },
  ];
  final List<dynamic> mechanic_availability_data = [
    {
      'serial_no': 01,
      'name': 'John Doe',
      'status': 'Working',
      'Vehicle': 'Toyota Camry',
      'Vehicle_no': 'ABC123',
      'time_slot': '10:00 AM - 12:00 PM',
    },
    {
      'serial_no': 02,
      'name': 'Alex Smith',
      'status': 'Working',
      'Vehicle': 'Range rover',
      'Vehicle_no': 'ABC123',
      'time_slot': '12:00 PM - 2:00 PM',
    },
/*    {
      'serial_no': 03,
      'name': 'Peter Parker',
      'status': 'idle',
      'Vehicle': '',
      'Vehicle_no': '',
      'time_slot': '',
    },*/
    {
      'serial_no': 04,
      'name': 'Lamby came',
      'status': 'Working',
      'Vehicle': 'Toyota Camry',
      'Vehicle_no': 'ABC123',
      'time_slot': '3:00 PM - 5:00 PM',
    },
/*    {
      'serial_no': 05,
      'name': 'Michele',
      'status': 'idle',
      'Vehicle': '',
      'Vehicle_no': '',
      'time_slot': '',
    },*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: Column(
        children: [
          Container(
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.builder(
              itemCount: top_widget_data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, context) {
                var icon = top_widget_data[context]['icon'];
                var title = top_widget_data[context]['title'];
                var value = top_widget_data[context]['value'];
                return DashTopWidget(icon: icon, title: title, value: value);
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
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
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.engineering_rounded, size: 30),
                                    SizedBox(width: 10),
                                    Text(
                                      'Mechanics Availability',
                                      style: TextStyle(
                                        color: AppColors.grey30,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'See All',
                                  style: TextStyle(
                                    color: AppColors.grey30,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'S.No.',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Status',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Working On',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Time Slot',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: AppColors.grey30,
                            endIndent: 10,
                            indent: 10,
                          ),
                          ListView.builder(
                            itemCount: mechanic_availability_data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var serial_no =
                                  mechanic_availability_data[index]['serial_no'];
                              var name =
                                  mechanic_availability_data[index]['name'];
                              var status =
                                  mechanic_availability_data[index]['status'];
                              var vehicle =
                                  mechanic_availability_data[index]['Vehicle']
                                          .isEmpty
                                      ? 'No Vehicle'
                                      : mechanic_availability_data[index]['Vehicle'];
                              // var vehicle_no = mechanic_availability_data[index]['Vehicle_no'];
                              var time_slot =
                                  mechanic_availability_data[index]['time_slot']
                                          .isEmpty
                                      ? 'No Time Slot'
                                      : mechanic_availability_data[index]['time_slot'];
                              return Container(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      serial_no.toString(),
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      name,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      vehicle,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      time_slot,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      color: AppColors.grey30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
