import 'package:frontend/base_provider.dart';
import 'package:frontend/features/admin/data/repostiroy/analytics_repo.dart';
import 'package:frontend/service_locator.dart';

class AnalyticsProvider extends BaseProvider {
  final AnalyticsRepository _repo = getIt<AnalyticsRepository>();

  String _selectedRange = 'Monthly';
  Map<String, dynamic> _analyticsData = {
    "totalSales": 0,
    "orders": 0,
    "profit": 0,
    "returns": 0,
    "chartData": <double>[],
  };

  String get selectedRange => _selectedRange;
  Map<String, dynamic> get analyticsData => _analyticsData;

  Future<void> loadAnalytics([String? range]) async {
    if (range != null) {
      _selectedRange = range;
    }

    setLoading(true);
    setError(null);
    try {
      _analyticsData = await _repo.getAnalytics(_selectedRange);
    } catch (e) {
      setError("Failed to load analytics: $e");
    } finally {
      setLoading(false);
    }
  }
}