import 'dart:convert';
import 'package:frontend/features/admin/data/service/admin_setting_service.dart';
import 'package:frontend/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminSettingsRepository {
  final AdminSettingsService _service = getIt<AdminSettingsService>();

  Future<void> logout() async {
    // Call the API (we don't strictly need to check status code if we are forcing a local logout anyway)
    await _service.logoutAdmin();

    // Clear stored token
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('x-auth-token');
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('x-auth-token'); // Fixed key

    if (token == null || token.isEmpty) {
      throw 'User not logged in or session expired.';
    }

    final response = await _service.changePassword(oldPassword, newPassword, token);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['msg'] ?? 'Password changed successfully!';
    } else {
      throw jsonDecode(response.body)['msg'] ?? jsonDecode(response.body)['error'] ?? 'Password change failed!';
    }
  }
}