import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';
import 'package:frontend/utils/colors.dart';

class EditEmployeeDialog extends StatefulWidget {
  final Map<String, dynamic> staff;

  const EditEmployeeDialog({super.key, required this.staff});

  @override
  State<EditEmployeeDialog> createState() => _EditEmployeeDialogState();
}

class _EditEmployeeDialogState extends State<EditEmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  final staffService = ReceptionistStaffServices();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController experienceController;
  late TextEditingController aboutController;
  late String selectedRole;

  bool isSaving = false;

  final List<String> roles = ['Mechanic', 'Intern', 'otherEmployee'];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.staff['staffName'] ?? '',
    );
    emailController = TextEditingController(
      text: widget.staff['staffEmail'] ?? '',
    );
    phoneController = TextEditingController(
      text: widget.staff['staffContactNumber'] ?? '',
    );
    experienceController = TextEditingController(
      text: widget.staff['staffExperience'] ?? '',
    );
    aboutController = TextEditingController(text: widget.staff['about'] ?? '');
    selectedRole = widget.staff['staffRole'] ?? 'otherEmployee';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    experienceController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isSaving = true);

      try {
        // TODO: Call your update API
        // await staffService.updateEmployee(
        //   context: context,
        //   staffId: widget.staff['_id'],
        //   staffName: nameController.text,
        //   staffEmail: emailController.text,
        //   staffContactNumber: phoneController.text,
        //   staffExperience: experienceController.text,
        //   staffRole: selectedRole,
        //   about: aboutController.text,
        // );

        if (!mounted) return;

        // Return updated data
        Navigator.pop(context, {
          ...widget.staff,
          'staffName': nameController.text,
          'staffEmail': emailController.text,
          'staffContactNumber': phoneController.text,
          'staffExperience': experienceController.text,
          'staffRole': selectedRole,
          'about': aboutController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Employee updated successfully'),
            backgroundColor: AppColors.status_completed,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      } finally {
        if (mounted) {
          setState(() => isSaving = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: nameController,
                        label: 'Full Name',
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: emailController,
                        label: 'Email Address',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: phoneController,
                        label: 'Phone Number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildRoleDropdown(),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: experienceController,
                        label: 'Experience (e.g., 3 years)',
                        icon: Icons.work_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter experience';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: aboutController,
                        label: 'About',
                        icon: Icons.info_outline,
                        maxLines: 4,
                        validator: (value) => null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.admin_primary, AppColors.admin_primary_light],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.edit_outlined, color: AppColors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Employee',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Update employee information',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: AppColors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.text_dark,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.admin_primary),
            hintText: 'Enter $label',
            hintStyle: TextStyle(color: AppColors.text_grey, fontSize: 14),
            filled: true,
            fillColor: AppColors.light_bg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.border_grey.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.admin_primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Role',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.text_dark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.light_bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border_grey.withOpacity(0.3)),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: selectedRole,
            icon: Icon(Icons.arrow_drop_down, color: AppColors.admin_primary),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.badge_outlined,
                color: AppColors.admin_primary,
              ),
            ),
            dropdownColor: AppColors.white,
            style: TextStyle(color: AppColors.text_dark, fontSize: 15),
            items:
                roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(
                      role == 'otherEmployee' ? 'Other Employee' : role,
                    ),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => selectedRole = newValue);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: isSaving ? null : () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: AppColors.border_grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.text_dark,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.admin_primary,
                    AppColors.admin_primary_light,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.admin_primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: isSaving ? null : _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    isSaving
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : Text(
                          'Save Changes',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
