import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/features/admin/Dashbaord/widgets/custom_container.dart';
import 'package:frontend/features/admin/Dashbaord/widgets/inventory_alert_widget.dart';
import 'package:frontend/features/admin/Dashbaord/widgets/mechanics_availability_widget.dart';
import 'package:frontend/features/admin/Dashbaord/widgets/revenue_widget.dart';
import 'package:frontend/features/admin/Dashbaord/widgets/todays_booking_widget.dart';
import 'package:frontend/utils/constant.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(text: 'Dashboard'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomContainer(
                title: "Today's Income",
                icon: Image.asset(ServiceIcons.incomeImage, width: 27),
                value: 1299,
              ),
              SizedBox(width: 8),
              CustomContainer(
                title: "Completed Services",
                icon: Image.asset(ServiceIcons.completed, width: 27),
                value: 45,
              ),
              SizedBox(width: 8),
              CustomContainer(
                title: "Active Services",
                icon: Image.asset(ServiceIcons.inProgress, width: 27),
                value: 6,
              ),
              SizedBox(width: 8),
              CustomContainer(
                title: "Pending Services",
                icon: Image.asset(ServiceIcons.scheduled, width: 27),
                value: 23,
              ),

              SizedBox(height: 40),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: RevenueWidget()),
                    SizedBox(width: 16),
                    Expanded(child: TodaysBookingWidget()),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: InventoryAlertWidget()),
                    SizedBox(width: 16),
                    Expanded(child: MechanicsAvailabilityWidget()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
