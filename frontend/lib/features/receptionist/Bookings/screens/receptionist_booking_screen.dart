import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/admin/widgets/notification_screen.dart';
import 'package:frontend/features/receptionist/Bookings/services/booking_services.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/edit_booking_widget.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/new_booking_widget.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';
import 'package:frontend/utils/colors.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  void _openNewBookingForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.8,
            child: const NewBookingWidget(),
          ),
        );
      },
    );
  }

  DateTime selectedDate = DateTime.now();
  VehicleBookingServices bookingServices = VehicleBookingServices();
  List<NewBooking> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookingData();
  }

  void fetchBookingData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchBookings = await bookingServices.fetchAllBookings(context);
      if (!mounted) {
        return;
      }
      setState(() {
        bookings = fetchBookings;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      CustomSnackBar.show(
        context,
        message: "Unable to load bookings, Please try again",
        backgroundColor: AppColors.error,
      );
    }
  }

  void deleteVehicleBooking(String bookingId) async {
    await bookingServices.deleteBooking(context: context, bookingId: bookingId);
    setState(() {
      bookings.removeWhere((booking) => booking.bookingId == bookingId);
    });
    fetchBookingData();
  }

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sky_blue_bg,
      appBar: _buildModernAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.all(isMobile(constraints.maxWidth) ? 16 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterSection(constraints.maxWidth),
                const SizedBox(height: 20),
                _buildBookingsTable(constraints.maxWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      toolbarHeight: isMobile(screenWidth) ? 180 : 150,
      backgroundColor: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.black.withOpacity(0.1),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.sky_blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.event_note_rounded,
                          color: AppColors.sky_blue,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bookings',
                              style: TextStyle(
                                fontSize: isMobile(screenWidth) ? 18 : 22,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Manage Bookings',
                              style: TextStyle(
                                fontSize: isMobile(screenWidth) ? 12 : 14,
                                color: AppColors.text_grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.light_bg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminNotificationScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.notifications_outlined),
                        color: AppColors.sky_blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.sky_blue,
                            AppColors.sky_blue_light,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.sky_blue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.light_bg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.border_grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: AppColors.text_grey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search bookings...',
                              hintStyle: TextStyle(color: AppColors.text_grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (!isMobile(screenWidth))
                          Icon(
                            Icons.filter_list_outlined,
                            color: AppColors.text_grey,
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.sky_blue, AppColors.sky_blue_light],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.sky_blue.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
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
                    onPressed: () => _openNewBookingForm(context),
                    child:
                        isMobile(screenWidth)
                            ? Icon(Icons.add_rounded, color: AppColors.white)
                            : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add_rounded, color: AppColors.white),
                                const SizedBox(width: 8),
                                Text(
                                  'Add Booking',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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

  Widget _buildFilterSection(double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Icon(Icons.filter_alt_outlined, color: AppColors.sky_blue),
          const SizedBox(width: 12),
          if (!isMobile(screenWidth))
            Text(
              'Filters',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text_dark,
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.sky_blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.sky_blue.withOpacity(0.3)),
              ),
              child: InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: AppColors.sky_blue,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        DateFormat('dd MMM yyyy').format(selectedDate),
                        style: TextStyle(
                          color: AppColors.text_dark,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsTable(double screenWidth) {
    if (isMobile(screenWidth)) {
      return _buildMobileBookingsList();
    } else {
      return _buildDesktopBookingsTable(screenWidth);
    }
  }

  // Mobile Card List View
  Widget _buildMobileBookingsList() {
    return Expanded(
      child:
          isLoading
              ? Center(
                child: CircularProgressIndicator(color: AppColors.sky_blue),
              )
              : ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.sky_blue.withOpacity(
                                  0.15,
                                ),
                                child: Text(
                                  booking.customerName[0].toUpperCase(),
                                  style: TextStyle(
                                    color: AppColors.sky_blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking.customerName,
                                      style: TextStyle(
                                        color: AppColors.text_dark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      booking.vehicleNumber,
                                      style: TextStyle(
                                        color: AppColors.text_grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
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
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: AppColors.border_grey.withOpacity(0.3),
                            height: 1,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.phone_outlined,
                            'Contact',
                            booking.customerContactNumber,
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.calendar_today,
                            'Booked',
                            DateFormat(
                              'dd MMM yyyy',
                            ).format(booking.bookedDate),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.event_available,
                            'Ready By',
                            DateFormat('dd MMM yyyy').format(booking.readyDate),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (context) => EditBookingWidget(
                                              booking: booking,
                                            ),
                                      ).then((updatedBooking) {
                                        if (updatedBooking is NewBooking) {
                                          setState(() {
                                            bookings[index] = updatedBooking;
                                          });
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      size: 18,
                                      color: AppColors.success,
                                    ),
                                    label: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: AppColors.success,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      _showDeleteDialog(
                                        context,
                                        bookings[index].bookingId,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      size: 18,
                                      color: AppColors.error,
                                    ),
                                    label: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: AppColors.error,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                },
              ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.text_grey),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            color: AppColors.text_grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.text_dark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Desktop/Tablet Table View with Horizontal Scroll
  // Replace the _buildDesktopBookingsTable method with this fixed version:

  Widget _buildDesktopBookingsTable(double screenWidth) {
    return Expanded(
      child: Container(
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
            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.sky_blue.withOpacity(0.08),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Customer Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Vehicle No',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Contact Number',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Booked Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Ready By',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Actions',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky_blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Table Body
            isLoading
                ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.sky_blue),
                  ),
                )
                : Expanded(
                  child: ListView.separated(
                    itemCount: bookings.length,
                    separatorBuilder:
                        (context, index) => Divider(
                          height: 1,
                          color: AppColors.border_grey.withOpacity(0.5),
                        ),
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            // Customer Name with Avatar
                            Expanded(
                              flex: 2,
                              child: Row(
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
                                  Expanded(
                                    child: Text(
                                      booking.customerName,
                                      style: TextStyle(
                                        color: AppColors.text_dark,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Vehicle Number
                            Expanded(
                              flex: 2,
                              child: Text(
                                booking.vehicleNumber,
                                style: TextStyle(
                                  color: AppColors.text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Contact Number
                            Expanded(
                              flex: 2,
                              child: Text(
                                booking.customerContactNumber,
                                style: TextStyle(
                                  color: AppColors.text_grey,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Booked Date
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: AppColors.text_grey,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      DateFormat(
                                        'dd MMM yyyy',
                                      ).format(booking.bookedDate),
                                      style: TextStyle(
                                        color: AppColors.text_grey,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Ready By Date
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.event_available,
                                    size: 14,
                                    color: AppColors.text_grey,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      DateFormat(
                                        'dd MMM yyyy',
                                      ).format(booking.readyDate),
                                      style: TextStyle(
                                        color: AppColors.text_grey,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Status Badge
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
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
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            // Actions (Edit & Delete)
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.success.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(8),
                                      constraints: const BoxConstraints(),
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        size: 18,
                                        color: AppColors.success,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => EditBookingWidget(
                                                booking: booking,
                                              ),
                                        ).then((updatedBooking) {
                                          if (updatedBooking is NewBooking) {
                                            setState(() {
                                              bookings[index] = updatedBooking;
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.error.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(8),
                                      constraints: const BoxConstraints(),
                                      icon: Icon(
                                        Icons.delete_outline,
                                        size: 18,
                                        color: AppColors.error,
                                      ),
                                      onPressed: () {
                                        _showDeleteDialog(
                                          context,
                                          bookings[index].bookingId,
                                        );
                                      },
                                    ),
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
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String bookingId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.error,
                  ),
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
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
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
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
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
}
