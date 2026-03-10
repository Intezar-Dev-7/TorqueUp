import 'dart:convert';
import 'package:frontend/features/receptionist/data/services/booking_service.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';
import 'package:frontend/service_locator.dart';

class BookingRepository {
  // Locate the service
  final VehicleBookingServices _service = getIt<VehicleBookingServices>();

  Future<void> createBooking(NewBooking newBooking) async {
    final res = await _service.newVehicleBooking(newBooking);
    if (res.statusCode != 201) {
      throw jsonDecode(res.body)['error'] ?? 'Failed to create booking';
    }
  }

  Future<List<NewBooking>> fetchAllBookings() async {
    final res = await _service.fetchAllBookings();
    if (res.statusCode == 200) {
      return NewBooking.listFromJson(res.body);
    } else {
      throw jsonDecode(res.body)['error'] ?? 'Failed to load bookings';
    }
  }

  Future<NewBooking> updateBooking(String bookingId, String status) async {
    final res = await _service.updateBookingDetails(bookingId, status);
    if (res.statusCode == 200) {
      return NewBooking.fromMap(jsonDecode(res.body));
    } else {
      throw jsonDecode(res.body)['error'] ?? 'Failed to update booking';
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    final res = await _service.deleteBooking(bookingId);
    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['error'] ?? 'Failed to delete booking';
    }
  }
}