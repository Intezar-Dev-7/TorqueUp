import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/features/admin/widgets/custom_container.dart';
import 'package:frontend/features/admin/widgets/revenue_widget.dart';
import 'package:frontend/features/admin/widgets/todays_booking_widget.dart';
import 'package:iconsax/iconsax.dart';

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomContainer(
                title: "Today's Income",
                icon: Icon(Iconsax.money, color: Colors.lightGreenAccent),
                value: 1299,
              ),
              CustomContainer(
                title: "Completed Services",
                icon: Icon(Icons.done, color: Colors.blueAccent),
                value: 45,
              ),
              CustomContainer(
                title: "Active Services",
                icon: Icon(Icons.car_repair_outlined, color: Colors.grey[90]),
                value: 6,
              ),
              CustomContainer(
                title: "Pending Services",
                icon: Icon(Icons.garage_outlined, color: Colors.yellowAccent),
                value: 23,
              ),

              SizedBox(height: 40),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RevenueWidget(),
                    SizedBox(width: 16),
                    TodaysBookingWidget(),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Expanded(child: InventoryAlertWidget()),
                    SizedBox(width: 16),
                    // Expanded(child: MechanicsAvailabilityWidget()),
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
