import 'package:flutter/material.dart';
import 'package:frontend/base_provider.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/receptionist/data/repository/receptionist_staff_repo.dart';
import 'package:frontend/service_locator.dart';

class ReceptionistStaffProvider extends BaseProvider {
  final ReceptionistStaffRepository _repo = getIt<ReceptionistStaffRepository>();

  List<Map<String, dynamic>> _mechanics = [];
  List<Map<String, dynamic>> _interns = [];
  List<Map<String, dynamic>> _otherEmployees = [];

  List<Map<String, dynamic>> get mechanics => _mechanics;
  List<Map<String, dynamic>> get interns => _interns;
  List<Map<String, dynamic>> get otherEmployees => _otherEmployees;

  // Load all staff roles simultaneously
  Future<void> loadAllStaff() async {
    setLoading(true);
    setError(null);
    try {
      final results = await Future.wait([
        _repo.getStaffByRole('Mechanic'),
        _repo.getStaffByRole('Intern'),
        _repo.getStaffByRole('otherEmployee'),
      ]);
      _mechanics = results[0];
      _interns = results[1];
      _otherEmployees = results[2];
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<bool> addStaff(BuildContext context, Map<String, dynamic> staffData) async {
    setLoading(true);
    try {
      final msg = await _repo.addStaff(staffData);
      if (context.mounted) CustomSnackBar.show(context, message: msg, backgroundColor: Colors.green, icon: Icons.check_circle);
      await loadAllStaff();
      return true;
    } catch (e) {
      if (context.mounted) CustomSnackBar.show(context, message: e.toString(), backgroundColor: Colors.redAccent);
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> updateStaff(BuildContext context, String staffId, Map<String, dynamic> staffData) async {
    setLoading(true);
    try {
      await _repo.updateStaff(staffId, staffData);
      if (context.mounted) CustomSnackBar.show(context, message: 'Employee Updated Successfully', backgroundColor: Colors.green);
      await loadAllStaff();
      return true;
    } catch (e) {
      if (context.mounted) CustomSnackBar.show(context, message: e.toString(), backgroundColor: Colors.redAccent);
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> deleteStaff(BuildContext context, String staffId) async {
    setLoading(true);
    try {
      await _repo.deleteEmployee(staffId);
      if (context.mounted) CustomSnackBar.show(context, message: 'Employee Deleted Successfully', backgroundColor: Colors.lightGreenAccent);
      await loadAllStaff();
      return true;
    } catch (e) {
      if (context.mounted) CustomSnackBar.show(context, message: e.toString(), backgroundColor: Colors.redAccent);
      return false;
    } finally {
      setLoading(false);
    }
  }
}