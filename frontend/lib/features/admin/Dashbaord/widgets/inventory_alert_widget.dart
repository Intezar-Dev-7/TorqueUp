import 'package:flutter/material.dart';

class InventoryAlertWidget extends StatefulWidget {
  const InventoryAlertWidget({super.key});

  @override
  State<InventoryAlertWidget> createState() => _InventoryAlertWidgetState();
}

class _InventoryAlertWidgetState extends State<InventoryAlertWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/sidebar_nav_icons/inventory.png",
                  width: 24,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                const Text(
                  "Inventory Status Alert",
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
                        label: Text('Product', style: TextStyle(fontSize: 12)),
                      ),
                      DataColumn(
                        label: Text('Quantity', style: TextStyle(fontSize: 12)),
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
                    rows: [],
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
