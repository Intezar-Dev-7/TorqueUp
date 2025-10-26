import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Settings/services/receptionist_settings_services.dart';
import 'package:frontend/utils/colors.dart';

class ReceptionistSettingsScreen extends StatefulWidget {
  const ReceptionistSettingsScreen({super.key});

  @override
  State<ReceptionistSettingsScreen> createState() =>
      _ReceptionistSettingsScreenState();
}

class _ReceptionistSettingsScreenState
    extends State<ReceptionistSettingsScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final FocusNode _oldPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();

  bool notificationsEnabled = true;
  final ReceptionistSettingsServices _receptionistSettingsServices =
      ReceptionistSettingsServices();
  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 900;
  bool isDesktop(double width) => width >= 900;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();

    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();

    super.dispose();
  }

  void logoutReceptionist() {
    _receptionistSettingsServices.logoutReceptionist(context: context);
  }

  Future<void> _changePassword() async {
    await _receptionistSettingsServices.changeReceptionistPassword(
      context: context,
      oldPassword: _oldPasswordController.text,
      newPassword: _newPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.sky_blue_bg,
      appBar: _buildAppBar(screenWidth),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView(
            padding: EdgeInsets.all(isMobile(screenWidth) ? 16 : 32),
            children: [
              // Notifications Card
              _buildSettingsCard(
                icon: Icons.notifications_outlined,
                title: "Notifications",
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.light_bg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.border_grey.withOpacity(0.5),
                    ),
                  ),
                  child: SwitchListTile(
                    title: Text(
                      "Enable Email Notifications",
                      style: TextStyle(
                        color: AppColors.text_dark,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      "Receive updates about bookings and staff",
                      style: TextStyle(
                        color: AppColors.text_grey,
                        fontSize: 13,
                      ),
                    ),
                    value: notificationsEnabled,
                    activeThumbColor: AppColors.sky_blue,
                    onChanged:
                        (value) => setState(() => notificationsEnabled = value),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Security Card
              _buildSettingsCard(
                icon: Icons.lock_outline_rounded,
                title: "Security",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text_grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      controller: _oldPasswordController,
                      focusNode: _oldPasswordFocusNode,
                      label: "Current Password",
                      icon: Icons.key_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      controller: _newPasswordController,
                      focusNode: _newPasswordFocusNode,
                      label: "New Password",
                      icon: Icons.lock_reset_outlined,
                    ),

                    const SizedBox(height: 24),
                    _buildSavePasswordButton(screenWidth),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Logout Button
              _buildLogoutButton(screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(double screenWidth) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.black.withOpacity(0.1),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.sky_blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.settings_outlined,
                color: AppColors.sky_blue,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: isMobile(screenWidth) ? 18 : 22,
                    color: AppColors.text_dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Manage your account settings',
                  style: TextStyle(
                    fontSize: isMobile(screenWidth) ? 12 : 14,
                    color: AppColors.text_grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.sky_blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: AppColors.sky_blue),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text_dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border_grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: true,
        style: TextStyle(color: AppColors.text_dark, fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.text_grey, fontSize: 14),
          prefixIcon: Icon(icon, color: AppColors.sky_blue, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildSavePasswordButton(double screenWidth) {
    return Container(
      width: isMobile(screenWidth) ? double.infinity : null,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.sky_blue, AppColors.sky_blue_light],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.sky_blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _changePassword,
        icon: Icon(Icons.save_outlined, color: AppColors.white, size: 20),
        label: Text(
          "Update Password",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(double screenWidth) {
    return Container(
      width: isMobile(screenWidth) ? double.infinity : null,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          _showLogoutDialog();
        },
        icon: Icon(Icons.logout_outlined, color: AppColors.white, size: 20),
        label: Text(
          "Logout",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.logout_rounded, color: AppColors.error),
                ),
                const SizedBox(width: 12),
                Text(
                  "Confirm Logout",
                  style: TextStyle(
                    color: AppColors.text_dark,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            content: Text(
              "Are you sure you want to logout?",
              style: TextStyle(color: AppColors.text_dark, fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: AppColors.text_grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    logoutReceptionist();
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
