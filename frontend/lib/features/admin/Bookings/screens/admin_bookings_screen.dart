import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/admin/widgets/notification_screen.dart';
import 'package:frontend/features/receptionist/Bookings/services/BookingServices.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/edit_booking_widget.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';
import 'package:frontend/utils/colors.dart';
import 'package:intl/intl.dart';

class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({super.key});

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
  final VehicleBookingServices bookingServices = VehicleBookingServices();
  List<NewBooking> bookings = [];
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();
  String searchQuery = '';

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  void initState() {
    super.initState();
    fetchBookingData();
  }

  void fetchBookingData() async {
    setState(() => isLoading = true);

    try {
      final fetched = await bookingServices.fetchAllBookings(context);
      if (!mounted) return;
      setState(() {
        bookings = fetched;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);

      CustomSnackBar.show(
        context,
        message: "Unable to load bookings. Please try again.",
        backgroundColor: AppColors.error,
      );
    }
  }

  void deleteVehicleBooking(String bookingId) async {
    await bookingServices.deleteBooking(context: context, bookingId: bookingId);

    setState(() {
      bookings.removeWhere((b) => b.bookingId == bookingId);
    });

    fetchBookingData();
  }

  List<NewBooking> get filteredBookings {
    if (searchQuery.isEmpty) return bookings;
    return bookings
        .where((booking) =>
    booking.customerName
        .toLowerCase()
        .contains(searchQuery.toLowerCase()) ||
        booking.vehicleNumber
            .toLowerCase()
            .contains(searchQuery.toLowerCase()) ||
        booking.customerContactNumber.contains(searchQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.admin_bg,
      appBar: _buildModernAppBar(screenWidth),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isMobile(screenWidth) ? 12 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatsRow(screenWidth),
              const SizedBox(height: 24),
              _buildBookingsSection(screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(double screenWidth) {
    return AppBar(
      toolbarHeight: isMobile(screenWidth) ? 160 : 140,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(isMobile(screenWidth) ? 8 : 10),
                        decoration: BoxDecoration(
                          color: AppColors.admin_primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.calendar_month_outlined,
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
                              isMobile(screenWidth)
                                  ? 'Bookings'
                                  : 'Bookings Management',
                              style: TextStyle(
                                fontSize: isMobile(screenWidth) ? 16 : 22,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (!isMobile(screenWidth)) ...[
                              const SizedBox(height: 2),
                              Text(
                                'View, edit, and manage all customer bookings',
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
                    ],
                  ),
                ),
                if (!isMobile(screenWidth))
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications_outlined,
                          color: AppColors.admin_primary,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AdminNotificationScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.admin_primary,
                            width: 2,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: isMobile(screenWidth) ? 12 : 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: isMobile(screenWidth) ? 45 : 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
                              hintText: isMobile(screenWidth)
                                  ? 'Search...'
                                  : 'Search by name, vehicle, or contact...',
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
                ),
                const SizedBox(width: 12),
                Container(
                  height: isMobile(screenWidth) ? 45 : 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.admin_primary,
                        AppColors.admin_primary_light,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.admin_primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: fetchBookingData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.transparent,
                      shadowColor: AppColors.transparent,
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: isMobile(screenWidth) ? 12 : 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Icon(
                      Icons.refresh_rounded,
                      color: AppColors.white,
                      size: isMobile(screenWidth) ? 20 : 24,
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

  Widget _buildStatsRow(double screenWidth) {
    final confirmedCount =
        bookings.where((b) => b.vehicleBookingStatus == 'Confirmed').length;
    final pendingCount =
        bookings.where((b) => b.vehicleBookingStatus == 'Pending').length;
    final completedCount =
        bookings.where((b) => b.vehicleBookingStatus == 'Completed').length;

    if (isMobile(screenWidth)) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total', bookings.length,
                    Icons.calendar_today_outlined, AppColors.admin_primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Confirmed', confirmedCount,
                    Icons.check_circle_outline, AppColors.status_completed),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Pending', pendingCount,
                    Icons.pending_outlined, AppColors.status_pending),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Completed', completedCount,
                    Icons.done_all_outlined, AppColors.admin_primary_dark),
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
        _buildStatCard('Total Bookings', bookings.length,
            Icons.calendar_today_outlined, AppColors.admin_primary),
        _buildStatCard('Confirmed', confirmedCount,
            Icons.check_circle_outline, AppColors.status_completed),
        _buildStatCard('Pending', pendingCount, Icons.pending_outlined,
            AppColors.status_pending),
        _buildStatCard('Completed', completedCount, Icons.done_all_outlined,
            AppColors.admin_primary_dark),
      ],
    );
  }

  Widget _buildStatCard(String title, int count, IconData icon, Color color) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = isMobile(screenWidth);

    return Container(
      padding: EdgeInsets.all(isSmall ? 14 : 20),
      width: isSmall ? null : 200,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
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
          Container(
            padding: EdgeInsets.all(isSmall ? 8 : 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: isSmall ? 20 : 28),
          ),
          SizedBox(height: isSmall ? 10 : 16),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: isSmall ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: AppColors.text_dark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: AppColors.text_grey,
              fontSize: isSmall ? 12 : 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsSection(double screenWidth) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 400,
        maxHeight: isMobile(screenWidth) ? 600 : 700,
      ),
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
        children: [
          // Title bar
          Padding(
            padding: EdgeInsets.all(isMobile(screenWidth) ? 16 : 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Customer Bookings',
                  style: TextStyle(
                    fontSize: isMobile(screenWidth) ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text_dark,
                  ),
                ),
                Icon(
                  Icons.filter_list,
                  color: AppColors.admin_primary,
                  size: isMobile(screenWidth) ? 20 : 24,
                ),
              ],
            ),
          ),

          // Content
          if (isMobile(screenWidth))
            Expanded(child: _buildMobileList())
          else
            Expanded(child: _buildDesktopTable(screenWidth)),
        ],
      ),
    );
  }

  // Mobile card list
  Widget _buildMobileList() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.admin_primary),
      );
    }

    if (filteredBookings.isEmpty) {
      return Center(
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
              'No bookings found',
              style: TextStyle(fontSize: 14, color: AppColors.text_grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filteredBookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final booking = filteredBookings[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.light_bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border_grey.withOpacity(0.3)),
          ),
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
                        fontSize: 15,
                        color: AppColors.text_dark,
                      ),
                    ),
                  ),
                  _buildStatusChip(booking.vehicleBookingStatus),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.directions_car_outlined,
                  booking.vehicleNumber, AppColors.text_dark),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.phone_outlined,
                  booking.customerContactNumber, AppColors.text_dark),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoRow(
                      Icons.calendar_today_outlined,
                      DateFormat('dd MMM').format(booking.bookedDate),
                      AppColors.text_grey,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoRow(
                      Icons.event_available_outlined,
                      DateFormat('dd MMM').format(booking.readyDate),
                      AppColors.text_grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => EditBookingWidget(booking: booking),
                        ).then((updatedBooking) {
                          if (updatedBooking is NewBooking) {
                            setState(() {
                              bookings[index] = updatedBooking;
                            });
                          }
                        });
                      },
                      icon: Icon(Icons.edit_outlined,
                          size: 16, color: AppColors.status_completed),
                      label: Text('Edit',
                          style: TextStyle(
                              color: AppColors.status_completed, fontSize: 13)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        side: BorderSide(color: AppColors.status_completed),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showDeleteDialog(booking.bookingId),
                      icon: Icon(Icons.delete_outline,
                          size: 16, color: AppColors.error),
                      label: Text('Delete',
                          style: TextStyle(
                              color: AppColors.error, fontSize: 13)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        side: BorderSide(color: AppColors.error),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color textColor) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.text_grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: textColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Desktop table
  Widget _buildDesktopTable(double screenWidth) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.admin_primary),
      );
    }

    if (filteredBookings.isEmpty) {
      return Center(
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
              'No bookings found',
              style: TextStyle(fontSize: 16, color: AppColors.text_grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Table header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.admin_primary.withOpacity(0.08),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Customer Name', 2),
              _buildHeaderCell('Vehicle No', 1),
              _buildHeaderCell('Contact', 1),
              _buildHeaderCell('Booked Date', 1),
              _buildHeaderCell('Ready By', 1),
              _buildHeaderCell('Status', 1),
              _buildHeaderCell('Actions', 1),
            ],
          ),
        ),

        // Table rows
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: filteredBookings.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: AppColors.border_grey.withOpacity(0.3),
            ),
            itemBuilder: (context, index) {
              final booking = filteredBookings[index];
              return Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    _buildDataCell(booking.customerName, 2, true),
                    _buildDataCell(booking.vehicleNumber, 1, false),
                    _buildDataCell(booking.customerContactNumber, 1, false),
                    _buildDataCell(
                        DateFormat('dd MMM yyyy').format(booking.bookedDate),
                        1,
                        false),
                    _buildDataCell(
                        DateFormat('dd MMM yyyy').format(booking.readyDate),
                        1,
                        false),
                    Expanded(
                      flex: 1,
                      child: _buildStatusChip(booking.vehicleBookingStatus),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                            icon: Icon(Icons.edit_outlined,
                                size: 18, color: AppColors.status_completed),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    EditBookingWidget(booking: booking),
                              ).then((updatedBooking) {
                                if (updatedBooking is NewBooking) {
                                  setState(() {
                                    bookings[index] = updatedBooking;
                                  });
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                            icon: Icon(Icons.delete_outline,
                                size: 18, color: AppColors.error),
                            onPressed: () =>
                                _showDeleteDialog(booking.bookingId),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.admin_primary,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, int flex, bool bold) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.text_dark,
          fontSize: 14,
          fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildStatusChip(String? status) {
    Color color = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status ?? 'Unknown',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Confirmed':
        return AppColors.status_completed;
      case 'Pending':
        return AppColors.status_pending;
      case 'Completed':
        return AppColors.admin_primary;
      case 'Cancelled':
        return AppColors.error;
      default:
        return AppColors.grey30;
    }
  }

  void _showDeleteDialog(String bookingId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.warning_amber_rounded, color: AppColors.error),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Confirm Deletion",
                style: TextStyle(
                  color: AppColors.text_dark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this booking? This action cannot be undone.',
          style: TextStyle(color: AppColors.text_dark, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: AppColors.text_grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                deleteVehicleBooking(bookingId);
                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
