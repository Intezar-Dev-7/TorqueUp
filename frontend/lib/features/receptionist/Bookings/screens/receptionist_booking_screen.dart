import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/admin/widgets/notification_screen.dart';
import 'package:frontend/features/receptionist/Bookings/services/BookingServices.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/edit_booking_widget.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/new_booking_widget.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';
import 'package:frontend/utils/colors.dart';
import 'package:intl/intl.dart'; // For date formatting

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
            borderRadius: BorderRadius.circular(15),
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
  // String selectedStatus = 'All';

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
        message: "Unable to load bookings , Please try again",
        backgroundColor: Colors.red,
      );
    }
  }

  void deleteVehicleBooking(String bookingId) async {
    await bookingServices.deleteBooking(context: context, bookingId: bookingId);
    // Remove the deleted booking from the list immediately
    setState(() {
      bookings.removeWhere((booking) => booking.bookingId == bookingId);
    });
    fetchBookingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title and user info row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Title & Subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bookings',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage Bookings',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  /// Notification + Profile
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminNotificationScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.notifications_none),
                        color: Colors.black,
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Search Bar + Button
              Row(
                children: [
                  /// Search bar container
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.filter_list_outlined,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// Action button (e.g., Add)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      minimumSize: const Size(100, 50),
                      backgroundColor: AppColors.black,
                      padding: EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _openNewBookingForm(context),

                    child: Text(
                      'Add Booking',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
            Row(
              children: [
                // Date Picker
                TextButton.icon(
                  onPressed: () async {
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
                  icon: const Icon(Icons.calendar_today, color: Colors.black),
                  label: Text(
                    DateFormat('dd MMM yyyy').format(selectedDate),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 16),

                // This dropdownmenu will  be used to filter the bookings by status
                // DropdownButton<String>(
                //   elevation: 1,
                //   focusColor: Colors.grey[100],
                //   borderRadius: BorderRadius.circular(15),
                //   value: selectedStatus,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedStatus = newValue!;
                //     });
                //   },
                //   items:
                //       ['All', 'Confirmed', 'Pending', 'Completed']
                //           .map(
                //             (status) => DropdownMenuItem<String>(
                //               value: status,
                //               child: Text(status),
                //             ),
                //           )
                //           .toList(),
                // ),
              ],
            ),
            const SizedBox(height: 24),

            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              color: Colors.grey.shade200,
              child: Row(
                children: const [
                  Expanded(flex: 1, child: Text('Customer Name')),
                  Expanded(flex: 1, child: Text('Vehicle No')),
                  Expanded(flex: 1, child: Text('Contact Number')),
                  Expanded(flex: 1, child: Text('Booked Date')),
                  Expanded(flex: 1, child: Text('Ready By')),
                  Expanded(flex: 1, child: Text('Status')),
                  Expanded(flex: 1, child: Text('Actions')),
                ],
              ),
            ),

            // Table Rows
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                  child: ListView.separated(
                    itemCount: bookings.length,
                    separatorBuilder:
                        (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(booking.customerName),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(booking.vehicleNumber),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(booking.customerContactNumber),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                DateFormat(
                                  'dd MMM yyyy',
                                ).format(booking.bookedDate),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                DateFormat(
                                  'dd MMM yyyy',
                                ).format(booking.readyDate),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                width: 8,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4.5),
                                ),
                                child: Text(
                                  booking.vehicleBookingStatus,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 18,
                                      color: Colors.green,
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
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (context) => AlertDialog(
                                              title: Text(
                                                "Confirm Deletion",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              content: Text(
                                                'Are you sure you want to delete this booking',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    deleteVehicleBooking(
                                                      bookings[index].bookingId,
                                                    ); // Delete booking
                                                    Navigator.pop(
                                                      context,
                                                    ); // Close dialog
                                                  },
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed:
                                                      () => Navigator.pop(
                                                        context,
                                                        true,
                                                      ),
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      );
                                    },
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

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
