import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({super.key});

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 👇 Add listener so UI rebuilds when switching tabs
    _tabController.addListener(() {
      setState(() {});
    });
  }

  String _selectedOption = "All";
  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bookings Dashboard",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          tabs: const [Tab(text: "Today's"), Tab(text: "Past")],
        ),
      ),
      body: Column(
        children: [
          // 🔍 Show search bar only for Upcoming + Past
          if (_tabController.index != 2)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search by customer or vehicle...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(18),
                    value: _selectedOption,
                    items: const [
                      DropdownMenuItem(value: "All", child: Text("All")),
                      DropdownMenuItem(
                        value: "Pending",
                        child: Text("Pending"),
                      ),
                      DropdownMenuItem(
                        value: "Completed",
                        child: Text("Completed"),
                      ),
                      DropdownMenuItem(
                        value: "Cancelled",
                        child: Text("Cancelled"),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _selectedOption = val!;
                      });
                    },
                  ),
                ],
              ),
            ),

          // 📌 Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBookingsList(context, "Today's"),
                _buildBookingsList(context, "past"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 📋 List of Bookings
  Widget _buildBookingsList(BuildContext context, String type) {
    final sampleBookings = [
      {
        "name": "John Doe",
        "vehicle": "Honda Civic",
        "status": "Pending",
        "date": "26 Aug, 10:00 AM",
      },
      {
        "name": "Alice Smith",
        "vehicle": "Yamaha R15",
        "status": "Completed",
        "date": "25 Aug, 02:30 PM",
      },
      {
        "name": "Robert Brown",
        "vehicle": "Toyota Innova",
        "status": "Ongoing",
        "date": "26 Aug, 12:00 PM",
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: sampleBookings.length,
      itemBuilder: (context, index) {
        final booking = sampleBookings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.shade100,
              child: Text(
                booking["name"]![0],
                style: const TextStyle(color: Colors.deepPurple),
              ),
            ),
            title: Text(booking["name"]!),
            subtitle: Text("${booking["vehicle"]} • ${booking["date"]}"),
            trailing: Chip(
              label: Text(booking["status"]!),
              backgroundColor: _getStatusColor(booking["status"]!),
            ),
          ),
        );
      },
    );
  }

  /// 🎨 Status Chip Colors
  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange.shade200;
      case "Completed":
        return Colors.green.shade200;
      case "Ongoing":
        return Colors.blue.shade200;
      case "Cancelled":
        return Colors.red.shade200;
      default:
        return Colors.grey.shade200;
    }
  }
}
