import 'dart:convert';
import 'package:frontend/utils/constant/api.dart';
import 'package:http/http.dart' as http;

class ReceptionistStaffService {
  Future<http.Response> addStaff(Map<String, dynamic> staffData) async {
    return await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/addStaff'),
      body: jsonEncode(staffData),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
  }

  Future<http.Response> getStaffByRole(String staffRole) async {
    return await http.get(Uri.parse('${ApiConfig.baseUrl}/api/getStaffByRole?staffRole=$staffRole'));
  }

  Future<http.Response> deleteEmployee(String staffId) async {
    return await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/api/deleteEmployee/$staffId'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
  }

  // Note: Added this for your Edit functionality
  Future<http.Response> updateStaff(String staffId, Map<String, dynamic> staffData) async {
    return await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/api/updateStaff/$staffId'),
      body: jsonEncode(staffData),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
  }
}