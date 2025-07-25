import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/common/widgets/dash_info_card.dart';

import 'package:frontend/features/admin/Dashbaord/widgets/inventory_alert_widget.dart';
import 'package:frontend/features/admin/Dashbaord/widgets/mechanics_availability_widget.dart';
import 'package:frontend/features/admin/Dashbaord/widgets/revenue_widget.dart';
import 'package:frontend/features/admin/Dashbaord/widgets/todays_booking_widget.dart';
import 'package:frontend/features/receptionist/data/dummy_data.dart';

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
      appBar: CustomAppbar(title: 'Dashboard', subtitle: ''),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: RevenueWidget()),
                        SizedBox(height: 16),
                        Expanded(child: InventoryAlertWidget()),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: TodaysBookingWidget()),
                        SizedBox(height: 16),
                        Expanded(child: MechanicsAvailabilityWidget()),
                      ],
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
