import 'dart:convert';
import 'package:frontend/features/receptionist/model/user_model.dart';
import 'package:frontend/utils/constant/api.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<http.Response> signUpUser({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    User user = User(
      id: '',
      name: name,
      password: password,
      email: email,
      address: '',
      role: role,
      token: '',
    );

    return await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/signup'),
      body: user.toJson(),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    );
  }

  Future<http.Response> signInUser({
    required String email,
    required String password,
    required String role,
  }) async {
    return await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/signin'),
      body: jsonEncode({"email": email, "password": password, "role": role}),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
  }

  Future<http.Response> validateToken(String token) async {
    return await http.post(
      Uri.parse('${ApiConfig.baseUrl}/tokenIsValid'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
    );
  }

  Future<http.Response> fetchUserData(String token) async {
    return await http.get(
      Uri.parse('${ApiConfig.baseUrl}/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
    );
  }
}