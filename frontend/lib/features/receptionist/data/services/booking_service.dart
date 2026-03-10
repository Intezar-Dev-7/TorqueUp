import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/utils/constant/api.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';

class VehicleBookingServices {
  Future<http.Response> newVehicleBooking(NewBooking newBooking) async {
    return await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/newBooking'),
      body: newBooking.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<http.Response> fetchAllBookings() async {
    return await http.get(Uri.parse('${ApiConfig.baseUrl}/api/getBookings'));
  }

  Future<http.Response> updateBookingDetails(String bookingId, String status) async {
    return await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/api/updateBooking/$bookingId'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({"status": status}),
    );
  }

  Future<http.Response> deleteBooking(String bookingId) async {
    return await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/api/deleteBooking/$bookingId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}