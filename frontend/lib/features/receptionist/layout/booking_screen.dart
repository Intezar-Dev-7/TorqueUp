import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BookingsPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class BookingsPage extends StatelessWidget {
  final List<Map<String, String>> bookings = [
    {
      'start': '9:00 AM',
      'end': '11:00 AM',
      'name': 'Hemant sahu',
      'vehicle': 'MP05MV6802',
      'type': 'Gen. service',
      'status': 'In service'
    },
    {
      'start': '11:00 AM',
      'end': '01:00 PM',
      'name': 'Rajaram sahu',
      'vehicle': 'MP05MV6802',
      'type': 'Gen. service',
      'status': 'In service'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Color(0xFFF7F9FB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(child: FlutterLogo(size: 60)),
                sidebarItem('Dashboard'),
                sidebarItem('Bookings'),
                sidebarItem('Customers'),
                sidebarItem('Services'),
                sidebarItem('Mechanics'),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bookings',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.notifications_none),
                          SizedBox(width: 10),
                          CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Text('C')),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Create Booking'),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Calendar
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFE5E9F3)),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text("September 2021",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              SizedBox(height: 10),
                              Wrap(
                                runSpacing: 8,
                                spacing: 8,
                                children: List.generate(
                                  30,
                                      (index) => CircleAvatar(
                                    backgroundColor: (index == 18)
                                        ? Colors.black
                                        : Colors.white,
                                    foregroundColor: (index == 18)
                                        ? Colors.white
                                        : Colors.black,
                                    child: Text('${index + 1}'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 20),

                      // Bookings
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bookings',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SizedBox(height: 20),
                            ...bookings.map((b) => BookingCard(data: b)).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sidebarItem(String title) {
    return ListTile(
      title: Text(title),
      leading: Icon(Icons.circle, size: 10),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Map<String, String> data;

  const BookingCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Time Slot
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['start']!, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(data['end']!),
              ],
            ),
            SizedBox(width: 20),
            Container(
              width: 2,
              height: 60,
              color: Colors.black,
            ),
            SizedBox(width: 20),
            // Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(data['vehicle']!),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Type', style: TextStyle(color: Colors.grey)),
                Text(data['type']!, style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Text('Status', style: TextStyle(color: Colors.grey)),
                Text(data['status']!, style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
