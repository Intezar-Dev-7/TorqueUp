import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Staff/services/receptionist_staff_services.dart';

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

  // New fields
  final TextEditingController _staffEmailController = TextEditingController();
  final TextEditingController _staffAboutController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  List<String> _skills = [];

  String _selectedRole = "Mechanic";

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
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Add Staff",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),

                  // Staff Name
                  TextFormField(
                    controller: _staffNameController,
                    decoration: InputDecoration(
                      labelText: "Staff Name",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter staff name"
                                : null,
                  ),
                  const SizedBox(height: 20),

                  // Staff Role Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: InputDecoration(
                      labelText: "Staff Role",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items:
                        const ["Other Employee", "Mechanic", "Intern"]
                            .map(
                              (role) => DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Show text field if "Other Employee" is selected
                  if (_selectedRole == "Other Employee")
                    TextFormField(
                      controller: _specificRoleController,
                      decoration: InputDecoration(
                        labelText: "Specify Role",
                        prefixIcon: const Icon(Icons.work_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (val) {
                        if (_selectedRole == "Other Employee" &&
                            (val == null || val.isEmpty)) {
                          return "Please specify the role";
                        }
                        return null;
                      },
                    ),
                  const SizedBox(height: 20),

                  // Experience
                  TextFormField(
                    controller: _staffExperienceController,
                    decoration: InputDecoration(
                      labelText: "Experience",
                      prefixIcon: const Icon(Icons.work_history),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter experience (e.g. 5 years)"
                                : null,
                  ),
                  const SizedBox(height: 20),

                  // Contact Number
                  TextFormField(
                    controller: _staffContactController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Contact Number",
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
                  const SizedBox(height: 20),

                  // Email
                  TextFormField(
                    controller: _staffEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) return null; // optional
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val))
                        return "Enter valid email";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // About
                  TextFormField(
                    controller: _staffAboutController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "About",
                      prefixIcon: const Icon(Icons.info),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Skills
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Skills",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _skillsController,
                              decoration: InputDecoration(
                                labelText: "Add Skill",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _addSkill,
                            child: const Text("Add"),
                          ),
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
                  ),
                  const SizedBox(height: 25),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: _saveStaff,
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
