import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';
import 'package:frontend/utils/constant/api.dart';
import 'package:http/http.dart' as http;

class VehicleBookingServices {
  void newVehicleBooking({
    required BuildContext context,
    required customerName,
    required vehicleNumber,
    required problem,
    required status,
    required bookedDate,
    required readyDate,
  }) async {
    try {
      NewBooking newBooking = NewBooking(
        bookingId: '',
        customerName: customerName,
        vehicleNumber: vehicleNumber,
        problem: problem,
        status: status,
        bookedDate: bookedDate,
        readyDate: readyDate,
      );

      // send a  post requried to backend

      http.Response res = await http.post(
        Uri.parse('$uri/api/newBooking'),
        body: newBooking.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("Response: ${res.statusCode} - ${res.body}");

      // Show success
      if (res.statusCode == 200) {
        CustomSnackBar.show(
          context,
          message: "Vehicle Booked Successfully!",
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      // Show success
      CustomSnackBar.show(
        context,
        message: "Something went wrong $e",
        backgroundColor: Colors.green,
      );
      print(e);
    }
  }

  Future<List<NewBooking>> fetchAllBookings(BuildContext context) async {
    try {
      final res = await http.get(Uri.parse('$uri/api/getBookings'));
      print('Fetch Response : ${res.statusCode}-${res.body}');
      if (res.statusCode == 200) {
        List<NewBooking> bookings = NewBooking.listFromJson(res.body);
        return bookings;
      } else {
        CustomSnackBar.show(
          context,
          message: "Failed to load bookings",
          backgroundColor: Colors.red,
        );
        return [];
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: "Error: $e",
        backgroundColor: Colors.red,
      );
      print(e);
      return [];
    }
  }

  // Funtion to update booking
  Future<NewBooking?> updateBookingDetails({
    required BuildContext context,
    required String bookingId,
    required String status,
  }) async {
    try {
      final res = await http.patch(
        Uri.parse('$uri/api/updateBooking/$bookingId'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({"status": status}),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        print("Full reponse $data");
        // Return updated booking
        return NewBooking.fromMap(data);
      } else {
        // Failure → show error from server
        CustomSnackBar.show(
          context,
          message: "Failed to update booking: ${res.body}",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Network/server error
      CustomSnackBar.show(
        context,
        message: "Error: $e",
        backgroundColor: Colors.red,
      );
    }
    return null;
  }

  // Function to delete vehicle booking
  Future<void> deleteBooking({
    required BuildContext context,
    required String bookingId,
  }) async {
    try {
      print("Success 3");
      http.Response res = await http.delete(
        Uri.parse('$uri/api/deleteBooking/$bookingId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        print("Success 4");
        print('Status Code:, ${res.statusCode}');
        print('Body, ${res.body}');

        CustomSnackBar.show(
          context,
          message: "Booking deleted successfully",
          backgroundColor: Colors.lightGreenAccent,
        );
      } else {
        print("Status Code: ${res.statusCode}");
        print("Body: ${res.body}");
        CustomSnackBar.show(
          context,
          message: "Failed to delete: ${res.body}",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: "Error: $e",
        backgroundColor: Colors.redAccent,
      );
    }
  }
}
