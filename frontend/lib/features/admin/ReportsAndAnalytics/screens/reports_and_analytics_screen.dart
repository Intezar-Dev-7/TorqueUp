import 'package:flutter/material.dart';
import 'package:frontend/features/admin/ReportsAndAnalytics/widgets/analytics.dart';
import 'package:frontend/features/admin/ReportsAndAnalytics/widgets/reports_charts.dart';
import 'package:frontend/features/admin/data/provider/analytics_provider.dart';
import 'package:frontend/utils/constant/colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ReportsAndAnalyticsScreen extends StatefulWidget {
  const ReportsAndAnalyticsScreen({super.key});

  @override
  State<ReportsAndAnalyticsScreen> createState() =>
      _ReportsAndAnalyticsScreenState();
}

class _ReportsAndAnalyticsScreenState extends State<ReportsAndAnalyticsScreen> {
  final List<String> rangeOptions = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AnalyticsProvider>(context, listen: false).loadAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<AnalyticsProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.admin_bg,
      appBar: _buildModernAppBar(screenWidth, provider),
      body:
          provider.isLoading
              ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.admin_primary,
                ),
              )
              : SingleChildScrollView(
                padding: EdgeInsets.all(isMobile(screenWidth) ? 16 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatsCards(screenWidth, provider.analyticsData),
                    const SizedBox(height: 24),
                    _buildFilterSection(screenWidth, provider),
                    const SizedBox(height: 24),
                    _buildChartSection(provider),
                  ],
                ),
              ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(
    double screenWidth,
    AnalyticsProvider provider,
  ) {
    return AppBar(
      toolbarHeight: isMobile(screenWidth) ? 100 : 120,
      backgroundColor: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.black.withOpacity(0.1),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile(screenWidth) ? 8 : 16,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile(screenWidth) ? 8 : 10),
                  decoration: BoxDecoration(
                    color: AppColors.admin_primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.analytics_outlined,
                    color: AppColors.admin_primary,
                    size: isMobile(screenWidth) ? 20 : 24,
                  ),
                ),
                SizedBox(width: isMobile(screenWidth) ? 8 : 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reports & Analytics',
                        style: TextStyle(
                          fontSize: isMobile(screenWidth) ? 18 : 22,
                          color: AppColors.text_dark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!isMobile(screenWidth)) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Track your business performance and insights',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.text_grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  height: isMobile(screenWidth) ? 40 : 45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.admin_primary,
                        AppColors.admin_primary_light,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.admin_primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed:
                        provider.isLoading
                            ? null
                            : () => provider.loadAnalytics(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile(screenWidth) ? 12 : 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(
                      Icons.refresh_rounded,
                      color: AppColors.white,
                      size: isMobile(screenWidth) ? 18 : 20,
                    ),
                    label:
                        isMobile(screenWidth)
                            ? const SizedBox.shrink()
                            : Text(
                              'Refresh',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(double screenWidth, Map<String, dynamic> data) {
    // Format numbers with commas (e.g., 45,000)
    final formatCurrency = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      name: '',
    );
    final formatNumber = NumberFormat.decimalPattern();

    if (isMobile(screenWidth)) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AnalyticsCard(
                  title: "Total Sales",
                  value: "\$${formatCurrency.format(data['totalSales'] ?? 0)}",
                  icon: Icons.monetization_on,
                  color: const Color(0xFF00897B),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnalyticsCard(
                  title: "Orders",
                  value: formatNumber.format(data['orders'] ?? 0),
                  icon: Icons.shopping_cart,
                  color: const Color(0xFF1E88E5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AnalyticsCard(
                  title: "Profit",
                  value: "\$${formatCurrency.format(data['profit'] ?? 0)}",
                  icon: Icons.trending_up,
                  color: const Color(0xFF43A047),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnalyticsCard(
                  title: "Returns",
                  value: formatNumber.format(data['returns'] ?? 0),
                  icon: Icons.undo,
                  color: const Color(0xFFE53935),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        AnalyticsCard(
          title: "Total Sales",
          value: "\$${formatCurrency.format(data['totalSales'] ?? 0)}",
          icon: Icons.monetization_on,
          color: const Color(0xFF00897B),
        ),
        AnalyticsCard(
          title: "Orders",
          value: formatNumber.format(data['orders'] ?? 0),
          icon: Icons.shopping_cart,
          color: const Color(0xFF1E88E5),
        ),
        AnalyticsCard(
          title: "Profit",
          value: "\$${formatCurrency.format(data['profit'] ?? 0)}",
          icon: Icons.trending_up,
          color: const Color(0xFF43A047),
        ),
        AnalyticsCard(
          title: "Returns",
          value: formatNumber.format(data['returns'] ?? 0),
          icon: Icons.undo,
          color: const Color(0xFFE53935),
        ),
      ],
    );
  }

  Widget _buildFilterSection(double screenWidth, AnalyticsProvider provider) {
    return Container(
      padding: EdgeInsets.all(isMobile(screenWidth) ? 16 : 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.filter_list_outlined,
            color: AppColors.admin_primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            'Time Range:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.text_dark,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.light_bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.admin_primary.withOpacity(0.3),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: AppColors.white,
                  value: provider.selectedRange,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.admin_primary,
                  ),
                  isExpanded: true,
                  style: TextStyle(
                    color: AppColors.text_dark,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  items:
                      rangeOptions.map((range) {
                        return DropdownMenuItem(
                          value: range,
                          child: Row(
                            children: [
                              Icon(
                                _getRangeIcon(range),
                                size: 18,
                                color: AppColors.admin_primary,
                              ),
                              const SizedBox(width: 8),
                              Text(range),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (newValue) => provider.loadAnalytics(newValue!),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getRangeIcon(String range) {
    switch (range) {
      case 'Daily':
        return Icons.today_outlined;
      case 'Weekly':
        return Icons.date_range_outlined;
      case 'Monthly':
        return Icons.calendar_month_outlined;
      case 'Yearly':
        return Icons.calendar_today_outlined;
      default:
        return Icons.calendar_today_outlined;
    }
  }

  Widget _buildChartSection(AnalyticsProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.admin_primary.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.admin_primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.bar_chart_outlined,
                    color: AppColors.admin_primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Performance Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.admin_primary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.admin_primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.trending_up, color: AppColors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '+12.5%',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Pass the dynamic data to the chart
          ReportsChart(
            selectedRange: provider.selectedRange,
            chartData: List<double>.from(
              provider.analyticsData['chartData'] ?? [],
            ),
          ),
        ],
      ),
    );
  }
}
