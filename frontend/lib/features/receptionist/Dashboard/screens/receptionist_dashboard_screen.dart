import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Inventory/services/inventory_services.dart';
import 'package:frontend/features/receptionist/model/inventory_model.dart';
import 'package:frontend/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:frontend/features/receptionist/Bookings/services/booking_services.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';

class ReceptionistDashboardScreen extends StatefulWidget {
  const ReceptionistDashboardScreen({super.key});

  @override
  State<ReceptionistDashboardScreen> createState() =>
      _ReceptionistDashboardScreenState();
}

class _ReceptionistDashboardScreenState
    extends State<ReceptionistDashboardScreen> {
  VehicleBookingServices bookingServices = VehicleBookingServices();
  final InventoryServices inventoryServices = InventoryServices();
  List<Inventory> inventoryList = [];
  List<NewBooking> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
    fetchProducts();
  }

  void fetchProducts() async {
    final fetchedInventory = await inventoryServices.fetchAllProducts(
      context: context,
    );

    setState(() {
      inventoryList = fetchedInventory;
      isLoading = false;
    });
  }

  Future<void> _loadBookings() async {
    setState(() => isLoading = true);
    bookings = await bookingServices.fetchAllBookings(context);
    setState(() => isLoading = false);
  }

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: _buildResponsiveAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isMobile(constraints.maxWidth)) {
            return _buildMobileLayout();
          } else if (isTablet(constraints.maxWidth)) {
            return _buildTabletLayout();
          } else {
            return _buildDesktopLayout();
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildResponsiveAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      automaticallyImplyLeading: false,
      shadowColor: Colors.black.withOpacity(0.1),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4FC3F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.dashboard_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Dashboard',
            style: TextStyle(
              color: AppColors.sky_blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        if (!isMobile(screenWidth))
          Container(
            width: isMobile(screenWidth) ? 180 : 260,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search bookings...',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        const SizedBox(width: 12),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.grey[600]),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  // Mobile Layout (< 600px)
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsGridMobile(),
          const SizedBox(height: 24),
          _buildActiveBookingsSection(),
          const SizedBox(height: 24),
          _buildInventorySection(),
        ],
      ),
    );
  }

  // Tablet Layout (600px - 1024px)
  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsGridTablet(),
          const SizedBox(height: 28),
          _buildActiveBookingsSection(),
          const SizedBox(height: 24),
          _buildInventorySection(),
        ],
      ),
    );
  }

  // Desktop Layout (>= 1024px)
  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsGridDesktop(),
                  const SizedBox(height: 28),
                  _buildActiveBookingsSection(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(flex: 1, child: _buildInventoryPanel()),
        ],
      ),
    );
  }

  // Stats Grid for Mobile
  Widget _buildStatsGridMobile() {
    return Column(
      children: [
        _buildStatCard(
          'Total Bookings',
          '248',
          '+12% from last month',
          Icons.calendar_today_rounded,
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          'Vehicles in Service',
          '34',
          '8 ready today',
          Icons.directions_car_rounded,
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          'Completed Jobs',
          '189',
          '+8% this week',
          Icons.check_circle_rounded,
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          'Pending Approvals',
          '15',
          '5 urgent',
          Icons.assignment_rounded,
        ),
      ],
    );
  }

  // Stats Grid for Tablet
  Widget _buildStatsGridTablet() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildStatCard(
          'Total Bookings',
          '248',
          '+12% from last month',
          Icons.calendar_today_rounded,
        ),
        _buildStatCard(
          'Vehicles in Service',
          '34',
          '8 ready today',
          Icons.directions_car_rounded,
        ),
        _buildStatCard(
          'Completed Jobs',
          '189',
          '+8% this week',
          Icons.check_circle_rounded,
        ),
        _buildStatCard(
          'Pending Approvals',
          '15',
          '5 urgent',
          Icons.assignment_rounded,
        ),
      ],
    );
  }

  // Stats Grid for Desktop
  Widget _buildStatsGridDesktop() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildStatCard(
          'Total Bookings',
          '248',
          '+12% from last month',
          Icons.calendar_today_rounded,
        ),
        _buildStatCard(
          'Vehicles in Service',
          '34',
          '8 ready today',
          Icons.directions_car_rounded,
        ),
        _buildStatCard(
          'Completed Jobs',
          '189',
          '+8% this week',
          Icons.check_circle_rounded,
        ),
        _buildStatCard(
          'Pending Approvals',
          '15',
          '5 urgent',
          Icons.assignment_rounded,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentWidth = MediaQuery.of(context).size.width;
        double cardWidth;

        if (isMobile(parentWidth)) {
          cardWidth = double.infinity; // Full width on mobile
        } else if (isTablet(parentWidth)) {
          cardWidth = (parentWidth - 68) / 2; // 2 columns on tablet
        } else {
          cardWidth = 200; // Fixed width on desktop
        }

        return Container(
          width: cardWidth,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.sky_blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.sky_blue, size: 24),
              ),
              const SizedBox(height: 16),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.sky_blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActiveBookingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.sky_blue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Active Bookings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildActiveBookingsTable(),
      ],
    );
  }

  Widget _buildActiveBookingsTable() {
    if (isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: CircularProgressIndicator(color: AppColors.sky_blue),
        ),
      );
    }

    if (bookings.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'No active bookings found.',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: isMobile(width) ? width : constraints.maxWidth,
              ),
              child: DataTable(
                columnSpacing: isMobile(width) ? 40 : 70,
                dataRowMaxHeight: 64,
                headingRowHeight: 56,
                headingRowColor: MaterialStateProperty.all(
                  AppColors.sky_blue.withOpacity(0.08),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      'Customer Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Vehicle Number',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Problem',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Ready Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
                rows:
                    bookings.map((booking) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppColors.sky_blue
                                      .withOpacity(0.15),
                                  child: Text(
                                    booking.customerName[0].toUpperCase(),
                                    style: TextStyle(
                                      color: AppColors.sky_blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  booking.customerName,
                                  style: const TextStyle(
                                    color: Color(0xFF2C3E50),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Text(
                              booking.vehicleNumber,
                              style: const TextStyle(
                                color: Color(0xFF2C3E50),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              booking.problem,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(
                                  booking.vehicleBookingStatus,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                booking.vehicleBookingStatus,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  DateFormat(
                                    'dd MMM yyyy',
                                  ).format(booking.readyDate),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In Progress':
        return AppColors.sky_blue;
      case 'Pending':
        return const Color(0xFFFFB74D);
      case 'Waiting Parts':
        return const Color(0xFF9E9E9E);
      case 'Completed':
        return const Color(0xFF66BB6A);
      default:
        return const Color(0xFF757575);
    }
  }

  // Inventory Section (for mobile and tablet)
  Widget _buildInventorySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.sky_blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.inventory_2_rounded,
                  color: AppColors.sky_blue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Inventory Status',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children:
                inventoryList.map((item) {
                  return _buildInventoryItem(
                    item.productName,
                    item.productQuantity,
                    item.productQuantity > 0,
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  // Inventory Panel (for desktop)
  Widget _buildInventoryPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.sky_blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.inventory_2_rounded,
                  color: AppColors.sky_blue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Inventory Status',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  inventoryList.map((item) {
                    return _buildInventoryItem(
                      item.productName,
                      item.productQuantity,
                      item.productQuantity > 0,
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItem(String name, int qty, bool inStock) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobileView = constraints.maxWidth < 400;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                inStock
                                    ? const Color(0xFF66BB6A).withOpacity(0.15)
                                    : const Color(0xFFFFB74D).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Qty: $qty',
                            style: TextStyle(
                              color:
                                  inStock
                                      ? const Color(0xFF66BB6A)
                                      : const Color(0xFFFFB74D),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!inStock && !isMobileView)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.sky_blue,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.sky_blue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Order',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              if (!inStock && isMobileView) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.sky_blue,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.sky_blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Order',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
