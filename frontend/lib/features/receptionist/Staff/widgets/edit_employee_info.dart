import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class EditEmployeeInfoWidget extends StatefulWidget {
  final String staffId;
  final String staffName;
  final String staffRole;
  final String staffExperience;
  final String staffContactNumber;
  final String staffEmail;
  final String staffAbout;
  final List<String> staffSkills;

  const EditEmployeeInfoWidget({
    super.key,
    required this.staffId,
    required this.staffName,
    required this.staffRole,
    required this.staffExperience,
    required this.staffContactNumber,
    this.staffEmail = '',
    this.staffAbout = '',
    this.staffSkills = const [],
  });

  @override
  State<EditEmployeeInfoWidget> createState() => _EditEmployeeInfoWidgetState();
}

class _EditEmployeeInfoWidgetState extends State<EditEmployeeInfoWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _experienceController;
  late TextEditingController _contactController;
  late TextEditingController _emailController;
  late TextEditingController _aboutController;
  late TextEditingController _skillsController;
  List<String> _skills = [];

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 900;
  bool isDesktop(double width) => width >= 900;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.staffName);
    _roleController = TextEditingController(text: widget.staffRole);
    _experienceController = TextEditingController(text: widget.staffExperience);
    _contactController = TextEditingController(text: widget.staffContactNumber);
    _emailController = TextEditingController(text: widget.staffEmail);
    _aboutController = TextEditingController(text: widget.staffAbout);
    _skills = List.from(widget.staffSkills);
    _skillsController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _experienceController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _aboutController.dispose();
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

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        'staffId': widget.staffId,
        'staffName': _nameController.text.trim(),
        'staffRole': _roleController.text.trim(),
        'staffExperience': _experienceController.text.trim(),
        'staffContactNumber': _contactController.text.trim(),
        'staffEmail': _emailController.text.trim(),
        'about': _aboutController.text.trim(),
        'skills': _skills,
      };
      Navigator.pop(context, updatedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = isMobile(screenWidth);

        return Container(
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
                          Icons.edit_outlined,
                          color: AppColors.sky_blue,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Edit Employee',
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

                  // Name
                  _buildTextField(
                    controller: _nameController,
                    label: 'Name',
                    icon: Icons.person_outline,
                    validator: (value) =>
                    (value == null || value.trim().isEmpty)
                        ? 'Name is required'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Role
                  _buildTextField(
                    controller: _roleController,
                    label: 'Role',
                    icon: Icons.badge_outlined,
                    validator: (value) =>
                    (value == null || value.trim().isEmpty)
                        ? 'Role is required'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Experience
                  _buildTextField(
                    controller: _experienceController,
                    label: 'Experience',
                    icon: Icons.work_history_outlined,
                    validator: (value) =>
                    (value == null || value.trim().isEmpty)
                        ? 'Experience is required'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Contact Number
                  _buildTextField(
                    controller: _contactController,
                    label: 'Contact Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Contact number is required';
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Enter valid 10-digit number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email (Optional)',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return null;
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // About
                  _buildTextField(
                    controller: _aboutController,
                    label: 'About (Optional)',
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
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
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
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(
          color: AppColors.text_dark,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.text_grey,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.sky_blue,
            size: 20,
          ),
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
                'Skills',
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
                    style: TextStyle(
                      color: AppColors.text_dark,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Add Skill',
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
                    'Add',
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
              children: _skills
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
        onPressed: _saveForm,
        icon: Icon(Icons.save_outlined, color: AppColors.white, size: 20),
        label: Text(
          'Save Changes',
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
          'Cancel',
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
