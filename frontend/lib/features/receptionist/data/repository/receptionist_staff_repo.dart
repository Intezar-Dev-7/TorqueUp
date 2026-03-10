import 'dart:convert';
import 'package:frontend/features/receptionist/data/services/receptionist_staff_service.dart';
import 'package:frontend/service_locator.dart';

class ReceptionistStaffRepository {
  final ReceptionistStaffService _service = getIt<ReceptionistStaffService>();

  Future<String> addStaff(Map<String, dynamic> staffData) async {
    final res = await _service.addStaff(staffData);
    if (res.statusCode == 201) {
      return jsonDecode(res.body)['message'] ?? "Added Staff successfully!";
    } else {
      throw jsonDecode(res.body)['error'] ?? "Failed to add staff";
    }
  }

  Future<List<Map<String, dynamic>>> getStaffByRole(String staffRole) async {
    final res = await _service.getStaffByRole(staffRole);
    if (res.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(res.body));
    } else {
      throw 'Unable to fetch Employees';
    }
  }

  Future<void> deleteEmployee(String staffId) async {
    final res = await _service.deleteEmployee(staffId);
    if (res.statusCode != 200) throw 'Unable to delete Employee';
  }

  Future<void> updateStaff(String staffId, Map<String, dynamic> staffData) async {
    final res = await _service.updateStaff(staffId, staffData);
    if (res.statusCode != 200) throw 'Unable to update Employee';
  }
}