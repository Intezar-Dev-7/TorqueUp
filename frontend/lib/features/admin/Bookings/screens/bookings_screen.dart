import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';
import 'package:intl/intl.dart'; // For date formatting

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // FocusNodes
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode vehicleFocusNode = FocusNode();
  final FocusNode timeFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    vehicleController.dispose();
    timeController.dispose();

    // Disposing all the focus nodes
    nameFocusNode.dispose();
    vehicleFocusNode.dispose();
    timeFocusNode.dispose();
  }

  DateTime selectedDate = DateTime.now();
  String selectedStatus = 'All';

  // Dummy data for bookings
  final List<Map<String, String>> bookings = [
    {
      'name': 'John Doe',
      'vehicle': 'Honda City',
      'status': 'Confirmed',
      'time': '10:00 AM',
    },
    {
      'name': 'Jane Smith',
      'vehicle': 'Yamaha FZ',
      'status': 'Pending',
      'time': '11:30 AM',
    },
    {
      'name': 'Alex Roy',
      'vehicle': 'KTM Duke',
      'status': 'Completed',
      'time': '2:00 PM',
    },
  ];
  void _showBookingDialog(Map<String, String> booking) {
    String status = booking['status'] ?? 'Pending';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Booking'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: nameController,
                  hintText: 'Customer Name',
                  focusNode: nameFocusNode,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: vehicleController,
                  hintText: 'Vehicle',
                  focusNode: vehicleFocusNode,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: timeController,
                  hintText: 'Time',
                  focusNode: timeFocusNode,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items:
                      ['Confirmed', 'Pending', 'Completed']
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                  onChanged: (val) {
                    status = val!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  booking['name'] = nameController.text;
                  booking['vehicle'] = vehicleController.text;
                  booking['time'] = timeController.text;
                  booking['status'] = status;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Bookings', subtitle: 'View Bookings'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
            Row(
              children: [
                // Date Picker
                TextButton.icon(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    DateFormat('dd MMM yyyy').format(selectedDate),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 16),

                // Status Dropdown
                DropdownButton<String>(
                  elevation: 1,

                  borderRadius: BorderRadius.circular(15),
                  value: selectedStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedStatus = newValue!;
                    });
                  },
                  items:
                      ['All', 'Confirmed', 'Pending', 'Completed']
                          .map(
                            (status) => DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              color: Colors.grey.shade200,
              child: Row(
                children: const [
                  Expanded(flex: 2, child: Text('Customer')),
                  Expanded(flex: 2, child: Text('Vehicle')),
                  Expanded(flex: 1, child: Text('Time')),
                  Expanded(flex: 1, child: Text('Status')),
                  Expanded(flex: 1, child: Text('Actions')),
                ],
              ),
            ),

            // Table Rows
            Expanded(
              child: ListView.separated(
                itemCount: bookings.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(booking['name']!)),
                        Expanded(flex: 2, child: Text(booking['vehicle']!)),
                        Expanded(flex: 1, child: Text(booking['time']!)),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(booking['status']),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              booking['status']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                onPressed: () {
                                  _showBookingDialog(booking);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 18),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
