import 'package:flutter/material.dart';
import 'package:frontend/base_provider.dart';
import 'package:frontend/features/receptionist/data/repository/booking_repo.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';
import 'package:frontend/service_locator.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';

class BookingProvider extends BaseProvider {
  final BookingRepository _repo = getIt<BookingRepository>();

  // Hold the list of bookings in memory
  List<NewBooking> _bookings = [];
  List<NewBooking> get bookings => _bookings;

  // 1. Add Booking
  Future<void> addBooking({
    required BuildContext context,
    required String customerName,
    required String vehicleNumber,
    required String customerContactNumber,
    required String problem,
    required String status,
    required DateTime bookedDate,
    required DateTime readyDate,
  }) async {
    setLoading(true);
    setError(null);
    try {
      NewBooking newBooking = NewBooking(
        bookingId: '',
        customerName: customerName,
        vehicleNumber: vehicleNumber,
        customerContactNumber: customerContactNumber,
        problem: problem,
        vehicleBookingStatus: status,
        bookedDate: bookedDate,
        readyDate: readyDate,
      );

      await _repo.createBooking(newBooking);
      CustomSnackBar.show(context, message: "Vehicle Booked Successfully!", backgroundColor: Colors.green);

      // Refresh the list after a successful creation
      await loadAllBookings(context: context);
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "Error: $e", backgroundColor: Colors.redAccent);
    } finally {
      setLoading(false);
    }
  }

  // 2. Fetch All Bookings
  Future<void> loadAllBookings({required BuildContext context}) async {
    setLoading(true);
    setError(null);
    try {
      _bookings = await _repo.fetchAllBookings();
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "Error: $e", backgroundColor: Colors.redAccent);
    } finally {
      setLoading(false); // UI will listen to this and hide the loading spinner
    }
  }

  // 3. Update Booking
  Future<void> updateBookingStatus({
    required BuildContext context,
    required String bookingId,
    required String status,
  }) async {
    setLoading(true);
    setError(null);
    try {
      final updatedBooking = await _repo.updateBooking(bookingId, status);

      // Update local list directly to avoid making another network call
      final index = _bookings.indexWhere((b) => b.bookingId == bookingId);
      if (index != -1) {
        _bookings[index] = updatedBooking;
      }
      CustomSnackBar.show(context, message: "Booking updated successfully", backgroundColor: Colors.green);
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "Error: $e", backgroundColor: Colors.redAccent);
    } finally {
      setLoading(false);
    }
  }

  // 4. Delete Booking
  Future<void> removeBooking({
    required BuildContext context,
    required String bookingId,
  }) async {
    setLoading(true);
    setError(null);
    try {
      await _repo.deleteBooking(bookingId);

      // Remove from local list so UI updates immediately
      _bookings.removeWhere((b) => b.bookingId == bookingId);
      CustomSnackBar.show(context, message: "Booking deleted successfully", backgroundColor: Colors.lightGreenAccent);
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "Error: $e", backgroundColor: Colors.redAccent);
    } finally {
      setLoading(false);
    }
  }
}