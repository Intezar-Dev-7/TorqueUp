import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/features/receptionist/Bookings/services/BookingServices.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';

class ReceptionistDashboardScreen extends StatefulWidget {
  const ReceptionistDashboardScreen({super.key});

  @override
  State<ReceptionistDashboardScreen> createState() =>
      _ReceptionistDashboardScreenState();
}

class _ReceptionistDashboardScreenState
    extends State<ReceptionistDashboardScreen> {
  VehicleBookingServices bookingServices = VehicleBookingServices();
  List<NewBooking> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    setState(() => isLoading = true);
    bookings = await bookingServices.fetchAllBookings(context);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Dashboard', style: TextStyle(color: Colors.blue)),
        actions: [
          SizedBox(
            width: 250,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search bookings, customers...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.grey),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column (main content)
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats cards
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildStatCard(
                          'Total Bookings',
                          '248',
                          '+12% from last month',
                          Icons.calendar_today,
                          Colors.blue,
                        ),
                        _buildStatCard(
                          'Vehicles in Service',
                          '34',
                          '8 ready today',
                          Icons.directions_car,
                          Colors.lightBlue,
                        ),
                        _buildStatCard(
                          'Completed Jobs',
                          '189',
                          '+8% this week',
                          Icons.check_circle,
                          Colors.blue[700]!,
                        ),
                        _buildStatCard(
                          'Pending Approvals',
                          '15',
                          '5 urgent',
                          Icons.assignment,
                          Colors.lightBlue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Active Bookings Table
                    const Text(
                      'Active Bookings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildActiveBookingsTable(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Right column (inventory)
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Inventory Status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildInventoryItem('Engine Oil 5W-30', 45, true),
                          _buildInventoryItem('Brake Pads Set', 8, false),
                          _buildInventoryItem('Air Filter', 15, true),
                          _buildInventoryItem('Spark Plugs', 32, true),
                          _buildInventoryItem('Transmission Fluid', 6, false),
                          _buildInventoryItem('Injector', 6, false),
                          _buildInventoryItem('Clutch Fail', 6, false),
                          _buildInventoryItem('Punctured', 6, false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveBookingsTable() {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (bookings.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No active bookings found.'),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 65,
          dataRowMaxHeight: 60,
          columns: const [
            DataColumn(label: Text('Customer Name')),
            DataColumn(label: Text('Vehicle Number')),
            DataColumn(label: Text('Problem')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Ready Date')),
          ],
          rows:
              bookings.map((booking) {
                return DataRow(
                  cells: [
                    DataCell(Text(booking.customerName)),
                    DataCell(Text(booking.vehicleNumber)),
                    DataCell(Text(booking.problem)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(booking.vehicleBookingStatus),
                          borderRadius: BorderRadius.circular(4.5),
                        ),
                        child: Text(
                          booking.vehicleBookingStatus,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(DateFormat('dd MMM yyyy').format(booking.readyDate)),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In Progress':
        return Colors.blue;
      case 'Pending':
        return Colors.orange;
      case 'Waiting Parts':
        return Colors.grey;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  Widget _buildInventoryItem(String name, int qty, bool inStock) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              const SizedBox(height: 4),
              Text(
                'Qty: $qty',
                style: TextStyle(color: inStock ? Colors.green : Colors.orange),
              ),
            ],
          ),
          if (!inStock)
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_shopping_cart, size: 16),
              label: const Text('Order', style: TextStyle(fontSize: 12)),
            ),
        ],
      ),
    );
  }
}
