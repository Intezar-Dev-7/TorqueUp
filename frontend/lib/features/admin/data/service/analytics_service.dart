import 'dart:convert';
// import 'package:frontend/utils/constant/api.dart';
// import 'package:http/http.dart' as http;

class AnalyticsService {
  // Simulating an API call for analytics data
  Future<Map<String, dynamic>> fetchAnalyticsData(String timeRange) async {
    // TODO: Replace with actual API call
    // return await http.get(Uri.parse('$uri/api/analytics?range=$timeRange'));

    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network

    // Mock Response
    return {
      "totalSales": 45000,
      "orders": 1234,
      "profit": 9300,
      "returns": 32,
      "chartData": _getMockChartData(timeRange),
    };
  }

  List<double> _getMockChartData(String range) {
    switch (range) {
      case 'Daily': return [25, 35, 45, 38, 55, 65, 70];
      case 'Weekly': return [30, 48, 42, 60, 72];
      case 'Monthly': return [20, 45, 60, 50, 70, 80];
      case 'Yearly': return [30, 55, 40, 75, 85];
      default: return [];
    }
  }
}