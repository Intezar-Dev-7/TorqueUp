import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportsChart extends StatelessWidget {
  const ReportsChart({super.key, required this.selectedRange});

  final String selectedRange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 360,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 20,
            getDrawingHorizontalLine:
                (value) => FlLine(color: Colors.grey.shade300, strokeWidth: 1),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                reservedSize: 40,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  const style = TextStyle(fontSize: 12);
                  if (selectedRange == 'Monthly') {
                    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                    return Text(
                      months[value.toInt() % months.length],
                      style: style,
                    );
                  } else {
                    const years = ['2020', '2021', '2022', '2023', '2024'];
                    return Text(
                      years[value.toInt() % years.length],
                      style: style,
                    );
                  }
                },
                interval: 1,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots:
                  selectedRange == 'Monthly'
                      ? [
                        FlSpot(0, 20),
                        FlSpot(1, 45),
                        FlSpot(2, 60),
                        FlSpot(3, 50),
                        FlSpot(4, 70),
                        FlSpot(5, 80),
                      ]
                      : [
                        FlSpot(0, 30),
                        FlSpot(1, 55),
                        FlSpot(2, 40),
                        FlSpot(3, 75),
                        FlSpot(4, 65),
                      ],
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.2),
              ),
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
