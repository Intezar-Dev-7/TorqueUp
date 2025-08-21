import 'package:flutter/material.dart';
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
      print('Logout error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
