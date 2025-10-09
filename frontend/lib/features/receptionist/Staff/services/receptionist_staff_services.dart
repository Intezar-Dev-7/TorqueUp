import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/utils/constant/api.dart';
import 'package:http/http.dart' as http;

class ReceptionistStaffServices {
  // Add Staff
  void addStaff({
    required BuildContext context,
    required String staffName,
    required String staffRole,
    required String staffExperience,
    required String staffContactNumber,
    required String staffEmail,
    required String staffAbout,
    required List<String> skills, // changed from String to List<String>
  }) async {
    try {
      // Create a Map including the new fields
      final staffData = {
        'staffName': staffName,
        'staffRole': staffRole,
        'staffExperience': staffExperience,
        'staffContactNumber': staffContactNumber,
        'staffEmail': staffEmail,
        'about': staffAbout,
        'skills': skills,
      };

      final res = await http.post(
        Uri.parse('$uri/api/addStaff'),
        body: jsonEncode(staffData),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 201) {
        final response = jsonDecode(res.body);
        print("Decoded response: $response");

        CustomSnackBar.show(
          context,
          message: response['message'] ?? "Added Staff successfully!",
          backgroundColor: Colors.green,
          icon: Icons.check_circle,
        );
      } else {
        final error = jsonDecode(res.body);
        print("Decoded error: $error");

        CustomSnackBar.show(
          context,
          message: error['error'] ?? "Failed to add staff",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: '$e',
        backgroundColor: Colors.redAccent,
      );
      print("error in catch, $e");
    }
  }

  // Fetch employees by role
  Future<List<Map<String, dynamic>>> getStaffByRole({
    required BuildContext context,
    required String staffRole,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/getStaffByRole?staffRole=$staffRole'),
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        CustomSnackBar.show(
          context,
          message: 'Unable to fetch Employees',
          backgroundColor: Colors.redAccent,
        );
        return [];
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: 'Error: $e',
        backgroundColor: Colors.redAccent,
      );
      return [];
    }
  }

  // Delete Employee
  Future<void> deleteEmployee({
    required BuildContext context,
    required String staffId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$uri/api/deleteEmployee/$staffId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        CustomSnackBar.show(
          context,
          message: 'Employee Deleted Successfully',
          backgroundColor: Colors.lightGreenAccent,
        );
      } else {
        CustomSnackBar.show(
          context,
          message: 'Unable to delete Employee',
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: 'Error: $e',
        backgroundColor: Colors.redAccent,
      );
    }
  }
}
