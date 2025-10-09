// import 'package:flutter/material.dart';

// class EditEmployeeInfoWidget extends StatefulWidget {
//   final String staffId;
//   final String staffName;
//   final String staffRole;
//   final String staffExperience;
//   final String staffContactNumber;
//   const EditEmployeeInfoWidget({
//     super.key,
//     required this.staffId,
//     required this.staffName,
//     required this.staffRole,
//     required this.staffExperience,
//     required this.staffContactNumber,
//   });

//   @override
//   State<EditEmployeeInfoWidget> createState() => _EditEmployeeInfoWidgetState();
// }

// class _EditEmployeeInfoWidgetState extends State<EditEmployeeInfoWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     return SafeArea(
//       child: Center(
//         child: Container(
//           height: mediaQuery.size.height * 0.7,
//           width: mediaQuery.size.width * 0.7,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

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
      // Collect all data here
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
      // TODO: Call API or pass data back
      Navigator.pop(context, updatedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: mediaQuery.size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Edit Employee',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(_nameController, 'Name'),
                  _buildTextField(_roleController, 'Role'),
                  _buildTextField(_experienceController, 'Experience'),
                  _buildTextField(
                    _contactController,
                    'Contact Number',
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    _emailController,
                    'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildTextField(_aboutController, 'About', maxLines: 3),
                  const SizedBox(height: 12),
                  _buildSkillsField(),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator:
            (value) =>
                (value == null || value.trim().isEmpty)
                    ? '$label is required'
                    : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildSkillsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _skillsController,
                decoration: InputDecoration(
                  labelText: 'Add Skill',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: _addSkill, child: const Text('Add')),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              _skills
                  .map(
                    (skill) => Chip(
                      label: Text(skill),
                      onDeleted: () => _removeSkill(skill),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
