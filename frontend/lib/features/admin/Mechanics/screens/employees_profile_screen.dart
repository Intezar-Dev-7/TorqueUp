import 'package:flutter/material.dart';

class EmployeesProfileScreen extends StatefulWidget {
  const EmployeesProfileScreen({super.key});

  @override
  State<EmployeesProfileScreen> createState() => _EmployeesProfileScreenState();
}

class _EmployeesProfileScreenState extends State<EmployeesProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=3',
                      ),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "John Doe",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Senior Mechanic",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text("johndoe@example.com"),
                        Text("+91 9876543210"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Info Cards
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _infoCard("Experience", "5 yrs"),
                    _infoCard("Leave Balance", "12 Days"),
                    _infoCard("Attendance", "96%"),
                    _infoCard("Joined", "Mar 2020"),
                  ],
                ),
                const SizedBox(height: 32),

                // Skills/Tags
                const Text(
                  "Skills",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: const [
                    Chip(label: Text("Engine Repair")),
                    Chip(label: Text("Diagnostics")),
                    Chip(label: Text("Team Management")),
                    Chip(label: Text("Hydraulics")),
                  ],
                ),
                const SizedBox(height: 32),

                // About Section
                const Text(
                  "About",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  "John is a highly experienced mechanic who specializes in engine diagnostics and repairs. "
                  "He plays a key role in training interns and maintaining service quality. "
                  "He is known for his reliability and dedication to his work.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        // Handle edit
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        // Handle deactivate
                      },
                      icon: const Icon(Icons.block, color: Colors.white),
                      label: const Text(
                        "Deactivate",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 200,
        height: 100,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
