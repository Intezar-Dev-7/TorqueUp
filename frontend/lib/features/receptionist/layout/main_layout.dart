// layout/main_layout.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Nav
          Container(
            width: 200,
            color: Color(0xFFF5F5F5),
            child: Column(
              children: [
                const SizedBox(height: 20),
                navItem(context, "Dashboard", "/dashboard", Icons.dashboard),
                navItem(context, "Bookings", "/bookings", Icons.calendar_today),
                navItem(context, "Customers", "/customers", Icons.people),
                navItem(context, "Services", "/services", Icons.build),
                navItem(context, "Mechanics", "/mechanics", Icons.engineering),
              ],
            ),
          ),

          // Main content + AppBar
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 60,
                  color: Colors.grey[100],
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Dashboard",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.mail_outline),
                          const SizedBox(width: 12),
                          Icon(Icons.notifications_none),
                          const SizedBox(width: 16),
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/avatar.png'),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Cody Fisher",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Owner", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(
    BuildContext context,
    String title,
    String route,
    IconData icon,
  ) {
    final isSelected = false;
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.black : Colors.grey),
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.black : Colors.grey),
      ),
      tileColor: isSelected ? Colors.white : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () => context.go(route),
    );
  }
}
