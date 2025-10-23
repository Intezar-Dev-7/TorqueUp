import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/auth/screens/signin_screen.dart';
import 'package:frontend/utils/constant/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  void logoutAdmin({required BuildContext context}) async {
    try {
      http.Response res = await http.get(Uri.parse('$uri/logout'));

      // Clear stored token/session in SharedPreferences
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.remove('x-auth-token');

      // navigate user back to login screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (Route<dynamic> route) => false, // remove all previous routes
      );
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: "Logged out successfully!",
        backgroundColor: Colors.green,
        icon: Icons.done,
      );
    }
  }

  Future<void> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print('Token from prefs: $token');

      if (token == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('User not logged in')));
        return;
      }

      print("Success");
      final response = await http.patch(
        Uri.parse('$uri/api/changePassword'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },

        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['msg'] ?? 'Password changed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error['msg'] ?? 'Password change failed!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
