import 'package:flutter/material.dart';
import 'package:frontend/base_provider.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/auth/screens/signin_screen.dart';
import 'package:frontend/features/receptionist/data/repository/receptionist_settings_repo.dart';
import 'package:frontend/service_locator.dart';

class ReceptionistSettingsProvider extends BaseProvider {
  final ReceptionistSettingsRepository _repo = getIt<ReceptionistSettingsRepository>();

  Future<void> logoutReceptionist(BuildContext context) async {
    setLoading(true);
    try {
      await _repo.logout();
      if (context.mounted) {
        CustomSnackBar.show(context, message: "Logged out successfully!", backgroundColor: Colors.green, icon: Icons.done);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
              (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.show(context, message: "Logout error: $e", backgroundColor: Colors.redAccent);
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
  }) async {
    setLoading(true);
    try {
      final message = await _repo.changePassword(oldPassword, newPassword);
      if (context.mounted) {
        CustomSnackBar.show(context, message: message, backgroundColor: Colors.green);
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.show(context, message: e.toString(), backgroundColor: Colors.redAccent);
      }
    } finally {
      setLoading(false);
    }
  }
}