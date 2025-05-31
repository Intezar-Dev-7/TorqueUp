import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garage Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Icon(Icons.garage, size: 40, color: Colors.black),
                const SizedBox(height: 40),
                _SidebarItem(icon: Icons.dashboard, title: 'Dashboard'),
                _SidebarItem(icon: Icons.book_online, title: 'Bookings'),
                _SidebarItem(icon: Icons.people, title: 'Customers'),
                _SidebarItem(icon: Icons.miscellaneous_services, title: 'Services'),
                _SidebarItem(icon: Icons.handyman, title: 'Mechanics'),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
                          const CircleAvatar(child: Icon(Icons.person)),
                          const SizedBox(width: 8),
                          const Text('Cody Fisher'),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      _StatCard(title: 'Active Services', count: 6, color: Colors.blue),
                      SizedBox(width: 16),
                      _StatCard(title: 'Completed Services', count: 39, color: Colors.green),
                      SizedBox(width: 16),
                      _StatCard(title: 'Pending Services', count: 20, color: Colors.orange),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      children: const [
                        Expanded(child: _MechanicAvailabilitySection()),
                        SizedBox(width: 16),
                        Expanded(child: _TodayAppointmentsSection()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SidebarItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _StatCard({required this.title, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Text('$count', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color))
          ],
        ),
      ),
    );
  }
}

class _MechanicAvailabilitySection extends StatelessWidget {
  const _MechanicAvailabilitySection();

  @override
  Widget build(BuildContext context) {
    return _buildCard(
      title: 'Mechanics Availability',
      headers: const ['S. No', 'Name', 'Status', 'Work on v.', 'Time Slot'],
      data: const [
        ['01', 'Mechanic one', 'Working', 'MP05 MW8402', '10:30AM - 12:30PM'],
        ['01', 'Mechanic one', 'Idle', '', ''],
        ['01', 'Mechanic one', 'Working', 'MP05 MW8402', '10:30AM - 12:30PM'],
      ],
    );
  }
}

class _TodayAppointmentsSection extends StatelessWidget {
  const _TodayAppointmentsSection();

  @override
  Widget build(BuildContext context) {
    return _buildCard(
      title: "Today's Appointments",
      headers: const ['S. No', 'Vehicle', 'Owner', 'Work', 'Time Slot', 'Status'],
      data: const [
        ['01', 'Tata Safari', 'Raja Ram.', 'Gen. Serv.', '10-11', '✓'],
        ['02', 'Tata Curvv', 'Hemant s.', 'Gen. Serv.', '11-12', '✓'],
        ['03', 'CT 100 ES', 'Hemant s.', 'Gen. Serv.', '12-1', '✕'],
        ['04', 'Shine 125', 'Bhupendr.', 'Gen. Serv.', '1-2', '✕'],
        ['05', 'Tata Safari', 'Raja Ram.', 'Gen. Serv.', '3-4', '✓'],
      ],
    );
  }
}

Widget _buildCard({
  required String title,
  required List<String> headers,
  required List<List<String>> data,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5,
          offset: const Offset(0, 2),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('See all', style: TextStyle(color: Colors.grey))
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: headers.map((h) => DataColumn(label: Text(h))).toList(),
            rows: data
                .map((row) => DataRow(cells: row.map((cell) => DataCell(Text(cell))).toList()))
                .toList(),
          ),
        ),
      ],
    ),
  );
}
