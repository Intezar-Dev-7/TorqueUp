import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';
import 'package:frontend/features/admin/Settings/services/admin_services.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final FocusNode _businessNameFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _zipFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();

  ///
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final FocusNode _oldPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();

  bool notificationsEnabled = true;

  final AdminServices _adminServices = AdminServices();

  @override
  void dispose() {
    _businessNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();

    _businessNameFocus.dispose();
    _cityFocus.dispose();
    _stateFocus.dispose();
    _zipFocus.dispose();
    _countryFocus.dispose();

    ///
    _oldPasswordController.dispose();
    _newPasswordController.dispose();

    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();

    super.dispose();
  }

  void logoutAdmin() {
    _adminServices.logoutAdmin(context: context);
  }

  Future<void> changePassword() async {
    _adminServices.changePassword(
      context: context,
      oldPassword: _oldPasswordController.text,
      newPassword: _newPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              children: [
                const Text(
                  "Admin Settings",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Manage admin-specific settings like security and alerts.",
                ),

                const SizedBox(height: 32),

                // ✅ Notifications
                _buildSettingsCard(
                  icon: Icons.email,
                  title: "Notifications",
                  child: SwitchListTile(
                    title: const Text("Enable Email Notifications"),
                    value: notificationsEnabled,
                    onChanged:
                        (value) => setState(() => notificationsEnabled = value),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Security (passwords)
                _buildSettingsCard(
                  icon: Icons.lock,
                  title: "Change Password",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: _oldPasswordController,
                        hintText: 'Enter old password',
                        focusNode: _oldPasswordFocusNode,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _newPasswordController,
                        focusNode: _newPasswordFocusNode,
                        hintText: 'Enter new password',
                      ),
                      const SizedBox(height: 12),

                      ElevatedButton.icon(
                        onPressed: changePassword,
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: const Text(
                          "Save Password",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                // Service Center form , to add business details
                _buildSettingsCard(
                  icon: Icons.business,
                  title: "Service Center Details",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: _businessNameController,
                        hintText: 'Enter Business Name',
                        focusNode: _businessNameFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Business name is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _cityController,
                        hintText: 'City',
                        focusNode: _cityFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter city";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _stateController,
                        hintText: 'State',
                        focusNode: _stateFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter state";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _zipController,
                        hintText: 'ZIP/Postal Code',
                        focusNode: _zipFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter ZIP code";
                          } else if (!RegExp(r'^\d{5,6}$').hasMatch(value)) {
                            return "Invalid ZIP code";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _countryController,
                        hintText: 'Country',
                        focusNode: _countryFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter country";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomElevatedButton(
                        text: 'Add',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // ✅ All fields valid
                            // TODO: Hook API for saving service center details
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ✅ Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: logoutAdmin,
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     // Save changes handler
                    //   },
                    //   icon: const Icon(Icons.save, color: Colors.white),
                    //   label: const Text(
                    //     "Save Changes",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.black,
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 24,
                    //       vertical: 14,
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Fixed helper method
  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 22, color: Colors.black),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 👇 This makes the child show inside the card
            child,
          ],
        ),
      ),
    );
  }
}
