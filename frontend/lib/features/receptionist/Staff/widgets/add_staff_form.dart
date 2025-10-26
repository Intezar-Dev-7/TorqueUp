import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';
import 'package:frontend/utils/colors.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({super.key});

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  final ReceptionistStaffServices _receptionistStaffServices =
      ReceptionistStaffServices();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _staffNameController = TextEditingController();
  final TextEditingController _staffExperienceController =
      TextEditingController();
  final TextEditingController _staffContactController = TextEditingController();
  final TextEditingController _specificRoleController = TextEditingController();
  final TextEditingController _staffEmailController = TextEditingController();
  final TextEditingController _staffAboutController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final List<String> _skills = [];

  String _selectedRole = "Mechanic";

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 900;
  bool isDesktop(double width) => width >= 900;

  @override
  void dispose() {
    _staffNameController.dispose();
    _staffExperienceController.dispose();
    _staffContactController.dispose();
    _specificRoleController.dispose();
    _staffEmailController.dispose();
    _staffAboutController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  void _addSkill() {
    final skill = _skillsController.text.trim();
    if (skill.isNotEmpty && !_skills.contains(skill)) {
      setState(() {
        _skills.add(skill);
        _skillsController.clear();
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      _skills.remove(skill);
    });
  }

  void _saveStaff() {
    if (_formKey.currentState!.validate()) {
      final roleToSend =
          _selectedRole == "Other Employee"
              ? _specificRoleController.text
              : _selectedRole;

      _receptionistStaffServices.addStaff(
        context: context,
        staffName: _staffNameController.text.trim(),
        staffRole: roleToSend.trim(),
        staffExperience: _staffExperienceController.text.trim(),
        staffContactNumber: _staffContactController.text.trim(),
        staffEmail: _staffEmailController.text.trim(),
        staffAbout: _staffAboutController.text.trim(),
        skills: _skills,
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = isMobile(screenWidth);

        // ✅ FIX: Wrap with Material widget
        return Material(
          type: MaterialType.transparency,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isSmallScreen ? screenWidth * 0.95 : 700,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            padding: EdgeInsets.all(isSmallScreen ? 20 : 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with Icon
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.sky_blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.person_add_outlined,
                            color: AppColors.sky_blue,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "Add Staff",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 20 : 24,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text_dark,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close_rounded,
                            color: AppColors.text_grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 28),

                    // Staff Name
                    _buildTextField(
                      controller: _staffNameController,
                      label: "Staff Name",
                      icon: Icons.person_outline,
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? "Enter staff name"
                                  : null,
                    ),
                    const SizedBox(height: 16),

                    // Staff Role Dropdown
                    _buildRoleDropdown(),
                    const SizedBox(height: 16),

                    // Specific Role (conditional)
                    if (_selectedRole == "Other Employee") ...[
                      _buildTextField(
                        controller: _specificRoleController,
                        label: "Specify Role",
                        icon: Icons.work_outline_rounded,
                        validator: (val) {
                          if (_selectedRole == "Other Employee" &&
                              (val == null || val.isEmpty)) {
                            return "Please specify the role";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Experience
                    _buildTextField(
                      controller: _staffExperienceController,
                      label: "Experience (e.g. 5 years)",
                      icon: Icons.work_history_outlined,
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? "Enter experience"
                                  : null,
                    ),
                    const SizedBox(height: 16),

                    // Contact Number
                    _buildTextField(
                      controller: _staffContactController,
                      label: "Contact Number",
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Enter contact number";
                        }
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(val)) {
                          return "Enter valid 10-digit number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email
                    _buildTextField(
                      controller: _staffEmailController,
                      label: "Email (Optional)",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val.isEmpty) return null;
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // About
                    _buildTextField(
                      controller: _staffAboutController,
                      label: "About (Optional)",
                      icon: Icons.info_outline_rounded,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),

                    // Skills Section
                    _buildSkillsSection(isSmallScreen),
                    SizedBox(height: isSmallScreen ? 24 : 32),

                    // Action Buttons
                    if (!isSmallScreen)
                      Row(
                        children: [
                          Expanded(child: _buildCancelButton()),
                          const SizedBox(width: 16),
                          Expanded(child: _buildSaveButton()),
                        ],
                      )
                    else ...[
                      _buildSaveButton(),
                      const SizedBox(height: 12),
                      _buildCancelButton(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
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
        keyboardType: keyboardType,
        maxLines: maxLines,
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
        validator: validator,
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border_grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedRole,
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        decoration: InputDecoration(
          labelText: 'Staff Role',
          labelStyle: TextStyle(color: AppColors.text_grey, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.badge_outlined,
            color: AppColors.sky_blue,
            size: 20,
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.sky_blue,
        ),
        items:
            ["Mechanic", "Intern", "Other Employee"]
                .map(
                  (role) => DropdownMenuItem(
                    value: role,
                    child: Text(
                      role,
                      style: TextStyle(
                        color: AppColors.text_dark,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
        onChanged: (value) {
          setState(() {
            _selectedRole = value!;
          });
        },
      ),
    );
  }

  Widget _buildSkillsSection(bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border_grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star_outline_rounded,
                color: AppColors.sky_blue,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "Skills",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.text_dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.border_grey.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: TextFormField(
                    controller: _skillsController,
                    style: TextStyle(color: AppColors.text_dark, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Add Skill",
                      hintStyle: TextStyle(
                        color: AppColors.text_grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onFieldSubmitted: (_) => _addSkill(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.sky_blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.sky_blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _addSkill,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.transparent,
                    shadowColor: AppColors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_skills.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  _skills
                      .map(
                        (skill) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.sky_blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.sky_blue.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                skill,
                                style: TextStyle(
                                  color: AppColors.sky_blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () => _removeSkill(skill),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 16,
                                  color: AppColors.sky_blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
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
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _saveStaff,
        icon: Icon(Icons.save_outlined, color: AppColors.white, size: 20),
        label: Text(
          "Save Staff",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.sky_blue.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: TextButton.icon(
        onPressed: () => Navigator.pop(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(Icons.close_rounded, color: AppColors.sky_blue, size: 20),
        label: Text(
          "Cancel",
          style: TextStyle(
            color: AppColors.sky_blue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
