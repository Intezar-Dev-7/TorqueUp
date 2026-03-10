import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/features/auth/data/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/service_locator.dart'; // Import where your getIt is

class AuthRepository {
  final AuthService _authService = getIt<AuthService>();

  Future<dynamic> signUp({required String name, required String email, required String password, required String role}) async {
    final res = await _authService.signUpUser(name: name, email: email, password: password, role: role);
    if (res.statusCode == 200 || res.statusCode == 201) return jsonDecode(res.body);
    throw jsonDecode(res.body);
  }

  Future<dynamic> signIn({required String email, required String password, required String role}) async {
    final res = await _authService.signInUser(email: email.trim(), password: password.trim(), role: role); // Added .trim() here!

    if (res.statusCode == 200) {
      final responseData = jsonDecode(res.body);
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString('x-auth-token', responseData['token']);
      return responseData;
    }

    // DEFENSIVE ERROR HANDLING
    try {
      final errorData = jsonDecode(res.body);
      throw errorData['error'] ?? errorData['msg'] ?? 'Login failed';
    } catch (e) {
      // If the body is empty or HTML, jsonDecode will fail. We catch that here.
      if (e.toString().contains('FormatException') || e.toString().contains('SyntaxError')) {
        throw 'Server Error (${res.statusCode}): Backend crashed or is unreachable.';
      }
      rethrow;
    }
  }

  Future<String?> getValidUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    if (token == null || token.isEmpty) return null;

    final tokenRes = await _authService.validateToken(token);
    if (jsonDecode(tokenRes.body) == true) {
      final userRes = await _authService.fetchUserData(token);
      return userRes.body;
    }
    return null;
  }
}