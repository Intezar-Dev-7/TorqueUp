import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({super.key});

  @override
  _AdminDashBoardScreenState createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: 'Admin Dashboard',
        subtitle: '',
        onPressed: () {},
        text: '',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // children: [
        //   Row(
        //     children:
        //         // top_widget_data.map((item) {
        //           return DashInfoCard(
        //   //           icon: item['icon'],
        //   //           title: item['title'],
        //   //           value: item['value'],
        //   //           iconSize: 22,
        //   //           titleSize: 12,
        //   //           valueSize: 20,
        //   //         );
        //   //       }).toList(),
        //   // ),
        //   SizedBox(height: 10),
        //   Expanded(
        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: Row(
        //         children: [
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 Expanded(child: RevenueWidget()),
        //                 SizedBox(height: 16),
        //                 // Expanded(child: InventoryAlertWidget()),
        //               ],
        //             ),
        //           ),
        //           SizedBox(width: 16),
        //           Expanded(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 // Expanded(child: TodaysBookingWidget()),
        //                 SizedBox(height: 16),
        //                 // Expanded(child: MechanicsAvailabilityWidget()),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
