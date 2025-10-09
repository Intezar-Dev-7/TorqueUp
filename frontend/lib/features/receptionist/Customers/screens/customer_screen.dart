import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';

class Customer {
  final String name;
  final String email;
  final String phone;

  Customer({required this.name, required this.email, required this.phone});
}

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Static demo data
    final List<Customer> customers = [
      Customer(
        name: "John Doe",
        email: "john@example.com",
        phone: "9876543210",
      ),
      Customer(
        name: "Jane Smith",
        email: "jane@example.com",
        phone: "9123456780",
      ),
      Customer(
        name: "Robert Brown",
        email: "robert@example.com",
        phone: "9012345678",
      ),
      Customer(
        name: "Emily Johnson",
        email: "emily@example.com",
        phone: "9876501234",
      ),
      Customer(
        name: "Robert Brown",
        email: "robert@example.com",
        phone: "9012345678",
      ),
      Customer(
        name: "Emily Johnson",
        email: "emily@example.com",
        phone: "9876501234",
      ),
    ];
    return Scaffold(
      appBar: CustomAppbar(
        subtitle: '',
        onPressed: () {},
        text: 'Search',
        title: '',
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blueGrey.shade100,
                child: Text(
                  customer.name[0],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              title: Text(
                customer.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(customer.email), Text("📞 ${customer.phone}")],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
