import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class ReportsChart extends StatelessWidget {
  const ReportsChart({super.key, required this.selectedRange});

  final String selectedRange;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      width: double.infinity,
      height: isMobile ? 300 : 400,
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 20,
            getDrawingHorizontalLine: (value) => FlLine(
              color: AppColors.border_grey.withOpacity(0.3),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                reservedSize: isMobile ? 35 : 45,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '\$${value.toInt()}k',
                    style: TextStyle(
                      color: AppColors.text_grey,
                      fontSize: isMobile ? 11 : 13,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, _) {
                  final style = TextStyle(
                    fontSize: isMobile ? 11 : 13,
                    color: AppColors.text_grey,
                    fontWeight: FontWeight.w500,
                  );

                  String label = '';
                  switch (selectedRange) {
                    case 'Daily':
                      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                      if (value.toInt() < days.length) {
                        label = days[value.toInt()];
                      }
                      break;
                    case 'Weekly':
                      const weeks = ['W1', 'W2', 'W3', 'W4', 'W5'];
                      if (value.toInt() < weeks.length) {
                        label = weeks[value.toInt()];
                      }
                      break;
                    case 'Monthly':
                      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                      if (value.toInt() < months.length) {
                        label = months[value.toInt()];
                      }
                      break;
                    case 'Yearly':
                      const years = ['2020', '2021', '2022', '2023', '2024'];
                      if (value.toInt() < years.length) {
                        label = years[value.toInt()];
                      }
                      break;
                  }
                  return Text(label, style: style);
                },
                interval: 1,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                color: AppColors.border_grey.withOpacity(0.3),
                width: 1,
              ),
              left: BorderSide(
                color: AppColors.border_grey.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: _getSpots(selectedRange),
              isCurved: true,
              curveSmoothness: 0.4,
              preventCurveOverShooting: true,
              gradient: LinearGradient(
                colors: [
                  AppColors.admin_primary,
                  AppColors.admin_primary_light,
                ],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: AppColors.white,
                    strokeWidth: 2,
                    strokeColor: AppColors.admin_primary,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppColors.admin_primary.withOpacity(0.3),
                    AppColors.admin_primary.withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => AppColors.admin_primary,
              tooltipPadding: const EdgeInsets.all(8),
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    '\$${spot.y.toStringAsFixed(0)}k',
                    TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  );
                }).toList();
              },
            ),
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((spotIndex) {
                return TouchedSpotIndicatorData(
                  FlLine(
                    color: AppColors.admin_primary.withOpacity(0.5),
                    strokeWidth: 2,
                    dashArray: [5, 5],
                  ),
                  FlDotData(
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 6,
                        color: AppColors.white,
                        strokeWidth: 3,
                        strokeColor: AppColors.admin_primary,
                      );
                    },
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  List<FlSpot> _getSpots(String range) {
    switch (range) {
      case 'Daily':
        return [
          const FlSpot(0, 25),
          const FlSpot(1, 35),
          const FlSpot(2, 45),
          const FlSpot(3, 38),
          const FlSpot(4, 55),
          const FlSpot(5, 65),
          const FlSpot(6, 70),
        ];
      case 'Weekly':
        return [
          const FlSpot(0, 30),
          const FlSpot(1, 48),
          const FlSpot(2, 42),
          const FlSpot(3, 60),
          const FlSpot(4, 72),
        ];
      case 'Monthly':
        return [
          const FlSpot(0, 20),
          const FlSpot(1, 45),
          const FlSpot(2, 60),
          const FlSpot(3, 50),
          const FlSpot(4, 70),
          const FlSpot(5, 80),
        ];
      case 'Yearly':
        return [
          const FlSpot(0, 30),
          const FlSpot(1, 55),
          const FlSpot(2, 40),
          const FlSpot(3, 75),
          const FlSpot(4, 85),
        ];
      default:
        return [];
    }
  }
}
