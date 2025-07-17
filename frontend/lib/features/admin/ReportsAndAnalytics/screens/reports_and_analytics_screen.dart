import 'package:flutter/material.dart';
import 'package:frontend/features/admin/ReportsAndAnalytics/widgets/analytics.dart';
import 'package:frontend/features/admin/ReportsAndAnalytics/widgets/reports_charts.dart';

class ReportsAndAnalyticsScreen extends StatefulWidget {
  const ReportsAndAnalyticsScreen({super.key});

  @override
  State<ReportsAndAnalyticsScreen> createState() =>
      _ReportsAndAnalyticsScreenState();
}

class _ReportsAndAnalyticsScreenState extends State<ReportsAndAnalyticsScreen> {
  String selectedRange = 'Monthly';
  final List<String> rangeOptions = ['Monthly', 'Yearly'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            const Text(
              "Analytics Overview",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Summary Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AnalyticsCard(
                  title: "Total Sales",
                  value: "\$45,000",
                  icon: Icons.monetization_on,
                ),
                AnalyticsCard(
                  title: "Orders",
                  value: "1,234",
                  icon: Icons.shopping_cart,
                ),
                AnalyticsCard(
                  title: "Profit",
                  value: "\$9,300",
                  icon: Icons.trending_up,
                ),
                AnalyticsCard(title: "Returns", value: "32", icon: Icons.undo),
              ],
            ),

            const SizedBox(height: 10),
            DropdownButton<String>(
              elevation: 1,
              borderRadius: BorderRadius.circular(15),
              value: selectedRange,
              items:
                  rangeOptions
                      .map(
                        (range) =>
                            DropdownMenuItem(value: range, child: Text(range)),
                      )
                      .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedRange = newValue!;
                });
              },
            ),

            // Chart Container
            ReportsChart(selectedRange: selectedRange),
          ],
        ),
      ),
    );
  }
}
