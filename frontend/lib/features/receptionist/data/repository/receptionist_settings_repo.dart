import 'dart:convert';
import 'package:frontend/features/receptionist/data/services/receptionist_settings_service.dart';
import 'package:frontend/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceptionistSettingsRepository {
  final ReceptionistSettingsService _service = getIt<ReceptionistSettingsService>();

  Future<void> logout() async {
    await _service.logoutReceptionist();
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