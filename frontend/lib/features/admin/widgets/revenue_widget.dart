import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RevenueWidget extends StatefulWidget {
  const RevenueWidget({super.key});

  @override
  State<RevenueWidget> createState() => _RevenueWidgetState();
}

class _RevenueWidgetState extends State<RevenueWidget> {
  String selectedView = 'Monthly';

  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr'];
  final List<String> years = ['2021', '2022', '2023', '2024'];

  final Random random = Random();

  List<BarChartGroupData> getBarGroups(List<String> labels) {
    return List.generate(labels.length, (i) {
      double value = random.nextInt(20) + 5;
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: value,
            width: 16,
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final labels = selectedView == 'Monthly' ? months : years;

    return Container(
      width: 400,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Iconsax.coin, color: Colors.lightGreenAccent),
                SizedBox(width: 8),
                const Text(
                  'Revenue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 190),
                DropdownButton<String>(
                  value: selectedView,
                  items: const [
                    DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
                    DropdownMenuItem(value: 'Yearly', child: Text('Yearly')),
                  ],
                  onChanged: (value) {
                    setState(() => selectedView = value!);
                  },
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  underline: const SizedBox(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: getBarGroups(labels),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          int index = value.toInt();
                          return index < labels.length
                              ? Text(
                                labels[index],
                                style: TextStyle(fontSize: 10),
                              )
                              : const SizedBox();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
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
