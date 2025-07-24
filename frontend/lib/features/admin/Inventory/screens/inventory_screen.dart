import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/features/admin/Inventory/widgets/inventory_containers.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppbar(
        title: 'Inventory',
        subtitle: 'Manage your Inventory',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InventoryContainers(
                  title: 'Total Products',
                  value: 1323,
                  icon: Icons.inventory,
                ),
                InventoryContainers(
                  title: 'Low Stock',
                  value: 12,
                  icon: Icons.warning,
                ),
                InventoryContainers(
                  title: 'Out of stock',
                  value: 5,
                  icon: Icons.hourglass_empty,
                ),
                InventoryContainers(
                  title: 'Total Value',
                  value: 12983,
                  icon: Icons.money_rounded,
                ),
              ],
            ),

            Expanded(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: DataTable(
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(label: Text('Product')),
                    DataColumn(label: Text('SKU')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Stock')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: [
                    _buildRow(
                      productName: 'Wireless Headphones',
                      subtitle: 'Premium Audio Device',
                      sku: 'WH-001',
                      category: 'Electronics',
                      stock: 45,
                      price: 99.99,
                      status: 'In Stock',
                      imageUrl: 'https://via.placeholder.com/40',
                    ),
                    _buildRow(
                      productName: 'Cotton T-Shirt',
                      subtitle: 'Basic Apparel',
                      sku: 'CT-002',
                      category: 'Clothing',
                      stock: 8,
                      price: 24.99,
                      status: 'Low Stock',
                      imageUrl: 'https://via.placeholder.com/40',
                    ),
                    _buildRow(
                      productName: 'Programming Book',
                      subtitle: 'Educational Material',
                      sku: 'PB-003',
                      category: 'Books',
                      stock: 0,
                      price: 49.99,
                      status: 'Out of Stock',
                      imageUrl: 'https://via.placeholder.com/40',
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

  DataRow _buildRow({
    required String productName,
    required String subtitle,
    required String sku,
    required String category,
    required int stock,
    required double price,
    required String status,
    required String imageUrl,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
        DataCell(Text(sku)),
        DataCell(Text(category)),
        DataCell(Text(stock.toString())),
        DataCell(Text('\$${price.toStringAsFixed(2)}')),
        DataCell(_buildStatusChip(status)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, color: Colors.lightGreenAccent),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'In Stock':
        color = Colors.green;
        break;
      case 'Low Stock':
        color = Colors.orange;
        break;
      case 'Out of Stock':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

// Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search Bar and Add Button Row
//             Row(
//               children: [
//                 // Search Bar
//                 Expanded(
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         searchQuery = value;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: "Search Inventory...",
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),

//                 // Add Item Button
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     showAddItemDialog(context);
//                   },
//                   icon: Icon(Icons.add),
//                   label: Text("Add Item"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 14.0,
//                       horizontal: 20.0,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Inventory List Container (Placeholder)
//           ],
//         ),
