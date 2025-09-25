import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/common/widgets/dash_info_card.dart';
import 'package:frontend/features/receptionist/Dashboard/widgets/todays_appointment_table.dart';
import 'package:frontend/utils/colors.dart';
import '../../../admin/data/dummy_data.dart';

class ReceptionistDashboardScreen extends StatelessWidget {
  const ReceptionistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Receptionist Dashboard',
        subtitle: 'Manage Bookings, Inventory, Customers, Staff',
        onPressed: () {},
        text: '!',
      ),

      backgroundColor: AppColors.white,
      body: Column(
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

          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // Expanded(child: MechanicsAvailabilityTable()),
                        SizedBox(height: 16),
                        // Expanded(child: InventoryStatusTable()),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: TodaysAppointmentsTable()),
                        SizedBox(height: 16),
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
