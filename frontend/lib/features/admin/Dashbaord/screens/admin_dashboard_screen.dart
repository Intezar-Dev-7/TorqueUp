import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Inventory/services/inventory_services.dart';
import 'package:frontend/features/receptionist/model/inventory_model.dart';
import 'package:intl/intl.dart';
import 'package:frontend/features/receptionist/Bookings/services/booking_services.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';
import 'package:frontend/utils/colors.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  VehicleBookingServices bookingServices = VehicleBookingServices();
  final InventoryServices inventoryServices = InventoryServices();

  List<Inventory> inventoryList = [];
  List<NewBooking> bookings = [];
  bool isLoading = true;
  String searchQuery = '';

  //  item.productQuantity.toString(),
  // item.productName,

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  void initState() {
    super.initState();
    _loadBookings();
    fetchProducts();
  }

  void fetchProducts() async {
    setState(() => isLoading = true);
    try {
      final fetchedInventory = await inventoryServices.fetchAllProducts(
        context: context,
      );
      if (!mounted) return;
      setState(() {
        inventoryList = fetchedInventory;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Unable to load inventory. Please try again."),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _loadBookings() async {
    setState(() => isLoading = true);
    bookings = await bookingServices.fetchAllBookings(context);
    setState(() => isLoading = false);
  }

  int get totalBookings => bookings.length;
  int get inProgressCount =>
      bookings.where((b) => b.vehicleBookingStatus == 'In Progress').length;
  int get completedCount =>
      bookings.where((b) => b.vehicleBookingStatus == 'Completed').length;
  int get pendingCount =>
      bookings.where((b) => b.vehicleBookingStatus == 'Pending').length;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = isMobile(screenWidth);
    final isMediumScreen = isTablet(screenWidth);

    return Scaffold(
      backgroundColor: AppColors.admin_bg,
      appBar: _buildModernAppBar(screenWidth),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats cards
            _buildStatsCards(screenWidth),
            const SizedBox(height: 24),

            // Main content area
            if (isDesktop(screenWidth))
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildActiveBookingsSection(screenWidth),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 320,
                    child: _buildInventorySidebar(screenWidth),
                  ),
                ],
              )
            else ...[
              _buildActiveBookingsSection(screenWidth),
              if (isMediumScreen) ...[
                const SizedBox(height: 24),
                _buildInventorySidebar(screenWidth),
              ],
            ],
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(double screenWidth) {
    final isSmallScreen = isMobile(screenWidth);

    return AppBar(
      toolbarHeight: isSmallScreen ? 70 : 80,
      backgroundColor: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.black.withOpacity(0.1),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
              decoration: BoxDecoration(
                color: AppColors.admin_primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.dashboard_outlined,
                color: AppColors.admin_primary,
                size: isSmallScreen ? 20 : 24,
              ),
            ),
            SizedBox(width: isSmallScreen ? 8 : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isSmallScreen ? 'Dashboard' : 'Admin Dashboard',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 22,
                      color: AppColors.text_dark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (!isSmallScreen) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Welcome back! Here\'s your overview',
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
            if (!isSmallScreen) ...[
              Container(
                width: 200,
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.light_bg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.border_grey.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: AppColors.admin_primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: AppColors.text_grey,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (query) {
                          setState(() => searchQuery = query);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: AppColors.admin_primary,
                size: isSmallScreen ? 22 : 24,
              ),
              onPressed: () {},
            ),
            if (!isSmallScreen) const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.admin_primary, width: 2),
              ),
              child: CircleAvatar(
                radius: isSmallScreen ? 16 : 20,
                backgroundImage: const NetworkImage(
                  "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(double screenWidth) {
    final isSmallScreen = isMobile(screenWidth);
    final cardWidth =
        isSmallScreen
            ? (screenWidth - 36) /
                2 // 2 cards per row on mobile
            : isTablet(screenWidth)
            ? (screenWidth - 56) /
                3 // 3 cards per row on tablet
            : 220.0; // Fixed width on desktop

    return Wrap(
      spacing: isSmallScreen ? 12 : 16,
      runSpacing: isSmallScreen ? 12 : 16,
      children: [
        _buildStatCard(
          'Total Bookings',
          totalBookings.toString(),
          '+12%',
          Icons.calendar_today_outlined,
          AppColors.admin_primary,
          cardWidth,
          isSmallScreen,
        ),
        _buildStatCard(
          'In Progress',
          inProgressCount.toString(),
          '$pendingCount waiting',
          Icons.sync_outlined,
          AppColors.status_in_progress,
          cardWidth,
          isSmallScreen,
        ),
        _buildStatCard(
          'Completed',
          completedCount.toString(),
          '+8%',
          Icons.check_circle_outline,
          AppColors.status_completed,
          cardWidth,
          isSmallScreen,
        ),
        _buildStatCard(
          'Pending',
          pendingCount.toString(),
          '5 urgent',
          Icons.pending_outlined,
          AppColors.status_pending,
          cardWidth,
          isSmallScreen,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    double width,
    bool isSmallScreen,
  ) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 14 : 20),
      width: width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: isSmallScreen ? 20 : 28),
              ),
              if (!isSmallScreen)
                Icon(
                  Icons.trending_up,
                  color: AppColors.status_completed,
                  size: 18,
                ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 10 : 16),
          Text(
            value,
            style: TextStyle(
              fontSize: isSmallScreen ? 22 : 28,
              fontWeight: FontWeight.bold,
              color: AppColors.text_dark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: AppColors.text_grey,
              fontSize: isSmallScreen ? 12 : 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: isSmallScreen ? 4 : 8),
          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: isSmallScreen ? 10 : 12,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveBookingsSection(double screenWidth) {
    final isSmallScreen = isMobile(screenWidth);

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
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Bookings',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text_dark,
                  ),
                ),
                if (!isSmallScreen)
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_list,
                      color: AppColors.admin_primary,
                      size: 20,
                    ),
                    label: Text(
                      'Filter',
                      style: TextStyle(color: AppColors.admin_primary),
                    ),
                  )
                else
                  IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: AppColors.admin_primary,
                      size: 22,
                    ),
                    onPressed: () {},
                  ),
              ],
            ),
          ),
          if (isSmallScreen)
            _buildMobileBookingsList()
          else
            _buildBookingsTable(screenWidth),
        ],
      ),
    );
  }

  Widget _buildMobileBookingsList() {
    if (isLoading) {
      return SizedBox(
        height: 300,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.admin_primary),
        ),
      );
    }

    if (bookings.isEmpty) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 48,
                color: AppColors.text_grey.withOpacity(0.5),
              ),
              const SizedBox(height: 12),
              Text(
                'No active bookings',
                style: TextStyle(fontSize: 14, color: AppColors.text_grey),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: bookings.take(5).length,
      separatorBuilder:
          (context, index) =>
              Divider(height: 1, color: AppColors.border_grey.withOpacity(0.3)),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      booking.customerName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.text_dark,
                      ),
                    ),
                  ),
                  _buildStatusChip(booking.vehicleBookingStatus),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    size: 16,
                    color: AppColors.text_grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    booking.vehicleNumber,
                    style: TextStyle(fontSize: 13, color: AppColors.text_grey),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.text_grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('dd MMM').format(booking.readyDate),
                    style: TextStyle(fontSize: 13, color: AppColors.text_grey),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                booking.problem,
                style: TextStyle(fontSize: 12, color: AppColors.text_grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBookingsTable(double screenWidth) {
    if (isLoading) {
      return SizedBox(
        height: 300,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.admin_primary),
        ),
      );
    }

    if (bookings.isEmpty) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 64,
                color: AppColors.text_grey.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No active bookings',
                style: TextStyle(fontSize: 16, color: AppColors.text_grey),
              ),
            ],
          ),
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: screenWidth - 40),
      child: DataTable(
        columnSpacing: 10,
        headingRowColor: WidgetStateProperty.all(
          AppColors.admin_primary.withOpacity(0.08),
        ),
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.admin_primary,
          fontSize: 14,
        ),
        dataTextStyle: TextStyle(color: AppColors.text_dark, fontSize: 14),
        columns: const [
          DataColumn(label: Text('Customer')),
          DataColumn(label: Text('Vehicle')),
          DataColumn(label: Text('Problem')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Ready Date')),
        ],
        rows:
            bookings.take(10).map((booking) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      booking.customerName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataCell(Text(booking.vehicleNumber)),
                  DataCell(
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        booking.problem,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(_buildStatusChip(booking.vehicleBookingStatus)),
                  DataCell(
                    Text(DateFormat('dd MMM yyyy').format(booking.readyDate)),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In Progress':
        return AppColors.status_in_progress;
      case 'Pending':
        return AppColors.status_pending;
      case 'Waiting Parts':
        return AppColors.status_waiting;
      case 'Completed':
        return AppColors.status_completed;
      default:
        return AppColors.grey30;
    }
  }

  Widget _buildInventorySidebar(double screenWidth) {
    final isSmallScreen = isMobile(screenWidth);

    return Container(
      constraints: BoxConstraints(
        maxHeight: isSmallScreen ? 400 : double.infinity,
      ),
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Inventory Status',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallScreen ? 14 : 16,
                  color: AppColors.text_dark,
                ),
              ),
              Icon(
                Icons.inventory_2_outlined,
                color: AppColors.admin_primary,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children:
                inventoryList.map((item) {
                  return _buildInventoryItem(
                    item.productName,
                    item.productQuantity,
                    item.productQuantity > 0,
                    isSmallScreen,
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItem(
    String name,
    int qty,
    bool inStock,
    bool isSmallScreen,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 8 : 12),
      padding: EdgeInsets.all(isSmallScreen ? 10 : 14),
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              inStock
                  ? AppColors.status_completed.withOpacity(0.2)
                  : AppColors.status_pending.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
            decoration: BoxDecoration(
              color: (inStock
                      ? AppColors.status_completed
                      : AppColors.status_pending)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              inStock
                  ? Icons.check_circle_outline
                  : Icons.warning_amber_rounded,
              color:
                  inStock
                      ? AppColors.status_completed
                      : AppColors.status_pending,
              size: isSmallScreen ? 16 : 20,
            ),
          ),
          SizedBox(width: isSmallScreen ? 8 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isSmallScreen ? 12 : 13,
                    color: AppColors.text_dark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  'Qty: $qty',
                  style: TextStyle(
                    color:
                        inStock
                            ? AppColors.status_completed
                            : AppColors.status_pending,
                    fontSize: isSmallScreen ? 10 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (!inStock)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 8 : 12,
                vertical: isSmallScreen ? 4 : 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.admin_primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    size: isSmallScreen ? 12 : 14,
                    color: AppColors.white,
                  ),
                  SizedBox(width: isSmallScreen ? 2 : 4),
                  Text(
                    'Order',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: isSmallScreen ? 10 : 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
