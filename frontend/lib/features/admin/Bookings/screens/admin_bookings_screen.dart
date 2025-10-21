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

  @override
  void initState() {
    super.initState();
    fetchBookingData();
  }

  /// Fetches all booking data for the admin
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
        backgroundColor: Colors.red,
      );
    }
  }

  /// Deletes a booking (admin privilege)
  void deleteVehicleBooking(String bookingId) async {
    await bookingServices.deleteBooking(context: context, bookingId: bookingId);

    setState(() {
      bookings.removeWhere((b) => b.bookingId == bookingId);
    });

    fetchBookingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Admin Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Admin Bookings Panel',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'View, edit, and manage all customer bookings',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        color: Colors.black,
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
              const SizedBox(height: 12),

              /// Search bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Search bookings...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              onChanged: (query) {
                                // TODO: Implement search/filter logic
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: fetchBookingData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text(
                      "Refresh",
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
            /// Date Filter
            Row(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() => selectedDate = picked);
                    }
                  },
                  icon: const Icon(Icons.calendar_today, color: Colors.black),
                  label: Text(
                    DateFormat('dd MMM yyyy').format(selectedDate),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Table header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              color: Colors.grey.shade200,
              child: const Row(
                children: [
                  Expanded(flex: 2, child: Text('Customer Name')),
                  Expanded(flex: 1, child: Text('Vehicle No')),
                  Expanded(flex: 1, child: Text('Contact')),
                  Expanded(flex: 1, child: Text('Booked Date')),
                  Expanded(flex: 1, child: Text('Ready By')),
                  Expanded(flex: 1, child: Text('Status')),
                  Expanded(flex: 1, child: Text('Actions')),
                ],
              ),
            ),

            /// Table content
            const SizedBox(height: 8),
            Expanded(
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : bookings.isEmpty
                      ? const Center(child: Text('No bookings found.'))
                      : ListView.separated(
                        itemCount: bookings.length,
                        separatorBuilder:
                            (_, __) =>
                                Divider(height: 1, color: Colors.grey[300]),
                        itemBuilder: (context, index) {
                          final booking = bookings[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
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
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(
                                        booking.vehicleBookingStatus,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
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
                                          color: Colors.green,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (_) => EditBookingWidget(
                                                  booking: booking,
                                                ),
                                          ).then((updatedBooking) {
                                            if (updatedBooking is NewBooking) {
                                              setState(() {
                                                bookings[index] =
                                                    updatedBooking;
                                              });
                                            }
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (_) => AlertDialog(
                                                  title: const Text(
                                                    "Confirm Deletion",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    "Are you sure you want to delete this booking?",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        deleteVehicleBooking(
                                                          booking.bookingId,
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.pop(
                                                            context,
                                                          ),
                                                      child: const Text(
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

  /// Color-coded status display for admin view
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
