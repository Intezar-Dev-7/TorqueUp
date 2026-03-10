import 'package:frontend/features/admin/data/service/analytics_service.dart';
import 'package:frontend/service_locator.dart';

class AnalyticsRepository {
  final AnalyticsService _service = getIt<AnalyticsService>();

  Future<Map<String, dynamic>> getAnalytics(String timeRange) async {
    // In the future, this is where you parse the JSON from the real API response
    return await _service.fetchAnalyticsData(timeRange);
  }
}