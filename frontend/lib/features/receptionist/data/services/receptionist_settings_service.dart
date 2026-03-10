import 'dart:convert';
import 'package:frontend/utils/constant/api.dart';
import 'package:http/http.dart' as http;

class ReceptionistSettingsService {
  Future<http.Response> logoutReceptionist() async {
    return await http.get(Uri.parse('${ApiConfig.baseUrl}/api/receptionistLogout'));
  }

  Future<http.Response> changePassword(String oldPassword, String newPassword, String token) async {
    return await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/api/changeReceptionistPassword'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );
  }
}