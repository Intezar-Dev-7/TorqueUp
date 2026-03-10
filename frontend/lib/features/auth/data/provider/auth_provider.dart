import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend/base_provider.dart';
import 'package:frontend/features/auth/data/repo/auth_repository.dart';
import 'package:frontend/service_locator.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';

// Import your navigation screens so the Provider can route the user
import 'package:frontend/admin_side_navigation_bar.dart';
import 'package:frontend/receptionist_side_nav_bar.dart';
import 'package:frontend/features/auth/screens/signin_screen.dart';

class AuthProvider extends BaseProvider {
  final AuthRepository _repo = getIt<AuthRepository>();

  // ----------------------------------------------------------------
  // SIGN IN METHOD
  // ----------------------------------------------------------------
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required String role,
  }) async {
    setLoading(true);
    setError(null);
    try {
      final data = await _repo.signIn(email: email, password: password, role: role);

      // The backend usually returns the token and the user object.
      // We pass the raw user data string/JSON to the UserProvider.
      Provider.of<UserProvider>(context, listen: false).setUser(jsonEncode(data['user'] ?? data));

      CustomSnackBar.show(context, message: "Login successful!", backgroundColor: Colors.green);

      // Navigate based on the role returned from the backend
      final String roleFromBackend = (data['user'] != null && data['user']['role'] != null)
          ? data['user']['role']
          : role;

      if (roleFromBackend.toLowerCase() == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminSideNavigationBar()),
        );
      } else if (roleFromBackend.toLowerCase() == 'receptionist') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReceptionistSideNavBar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      }
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "Login Failed: $e", backgroundColor: Colors.redAccent);
    } finally {
      setLoading(false);
    }
  }

  // ----------------------------------------------------------------
  // SIGN UP METHOD
  // ----------------------------------------------------------------
  Future<void> signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    setLoading(true);
    setError(null);
    try {
      final data = await _repo.signUp(name: name, email: email, password: password, role: role);

      CustomSnackBar.show(
        context,
        message: "Account created successfully!",
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );

      // Navigate based on the role provided or returned
      String userRole = data['role'] ?? role;
      Widget targetScreen;

      if (userRole.toLowerCase() == "admin") {
        targetScreen = const AdminSideNavigationBar();
      } else if (userRole.toLowerCase() == "receptionist") {
        targetScreen = const ReceptionistSideNavBar();
      } else {
        targetScreen = Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
            child: Text(
              'Invalid role: $userRole',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        );
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => targetScreen),
            (route) => false,
      );
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "$e", backgroundColor: Colors.redAccent);
    } finally {
      setLoading(false);
    }
  }

  // ----------------------------------------------------------------
  // GET USER DATA METHOD
  // ----------------------------------------------------------------
  Future<void> getUserData({required BuildContext context}) async {
    setLoading(true);
    setError(null);
    try {
      // The repository handles grabbing the token and validating it
      final userDataString = await _repo.getValidUserData();

      if (userDataString != null) {
        // If valid, populate the UserProvider so the SplashWrapper routes them automatically
        Provider.of<UserProvider>(context, listen: false).setUser(userDataString);
      }
    } catch (e) {
      setError(e.toString());
      // We usually don't show a snackbar here because this runs silently in the background
      // during the Splash Screen phase. If it fails, they just stay logged out.
      debugPrint("GetUserData Error: $e");
    } finally {
      setLoading(false);
    }
  }
}