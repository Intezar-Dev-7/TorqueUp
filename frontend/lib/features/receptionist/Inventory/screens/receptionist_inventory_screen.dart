import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';
import 'package:frontend/features/receptionist/Inventory/services/inventory_services.dart';
import 'package:frontend/features/receptionist/Inventory/widgets/add_inventory_form.dart';
import 'package:frontend/features/receptionist/model/inventory_model.dart';

class ReceptionistInventoryScreen extends StatefulWidget {
  const ReceptionistInventoryScreen({super.key});

  @override
  State<ReceptionistInventoryScreen> createState() =>
      _ReceptionistInventoryScreenState();
}

class _ReceptionistInventoryScreenState
    extends State<ReceptionistInventoryScreen> {
  String searchQuery = "";

  final InventoryServices inventoryServices = InventoryServices();

  List<Inventory> inventoryList = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void deleteInventoryProduct(String productId) async {
    await inventoryServices.deleteProduct(
      context: context,
      productId: productId,
    );
    setState(() {
      inventoryList.removeWhere(
        (inventory) => inventory.productId == productId,
      );
    });
    fetchProducts();
  }

  void fetchProducts() async {
    final fetchedInventory = await inventoryServices.fetchAllProducts(
      context: context,
    );

    setState(() {
      inventoryList = fetchedInventory;
      isLoading = false;
    });
  }

  void _openInventoryBookingForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.7,
            child: const AddInventoryForm(),
          ),
        );
      },
    ).then((_) {
      // Refresh data when the form is closed (e.g., after a successful addition)
      // Re-set isLoading to true before fetching to show a loading indicator if needed
      setState(() {
        isLoading = true;
      });
      fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppbar(
        title: 'Inventory',
        subtitle: 'Manage your Inventory',
        onPressed: () => _openInventoryBookingForm(context),
        text: 'Add Inventory',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInventoryCard(
                  title: 'Total Products',
                  value: 1323,
                  icon: Icons.inventory_2,
                  color: Colors.blue,
                ),
                _buildInventoryCard(
                  title: 'Low Stock',
                  value: 12,
                  icon: Icons.warning_amber_rounded,
                  color: Colors.orange,
                ),
                _buildInventoryCard(
                  title: 'Out of stock',
                  value: 5,
                  icon: Icons.hourglass_bottom,
                  color: Colors.red,
                ),
                _buildInventoryCard(
                  title: 'Total Value',
                  value: 12983,
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child:
                      isLoading
                          ? const CircularProgressIndicator() // Show loading indicator
                          : inventoryList.isEmpty
                          ? const Text(
                            'No inventory items found.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ) // Show empty state
                          : ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width,
                              minHeight: MediaQuery.of(context).size.height,
                            ),
                            child: DataTable(
                              headingRowColor: WidgetStateColor.resolveWith(
                                (states) => Colors.grey.shade200,
                              ),
                              columnSpacing: 25,
                              columns: const [
                                DataColumn(label: Text('Product Name ')),
                                DataColumn(label: Text('Quantity')),
                                DataColumn(label: Text('Price')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Actions')),
                              ],
                              rows:
                                  inventoryList.map((item) {
                                    return _buildRow(
                                      productId: item.productId,
                                      productName: item.productName,
                                      productQuantity: item.productQuantity,
                                      productPrice: item.productPrice,
                                      productStatus: item.productStatus,
                                      productImageBytes: item.productImageBytes,
                                    );
                                  }).toList(),
                            ),
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryCard({
    required String title,
    required int value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.3),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  DataRow _buildRow({
    required String productId,
    required String productName,
    required int productQuantity,
    required int productPrice,
    required String productStatus,
    Uint8List? productImageBytes,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    productImageBytes != null
                        ? MemoryImage(productImageBytes)
                        : const NetworkImage('https://via.placeholder.com/40')
                            as ImageProvider,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
        ),
        DataCell(Text(productQuantity.toString())),
        DataCell(Text('\$${productPrice.toDouble().toStringAsFixed(2)}')),
        DataCell(_buildStatusChip(productStatus)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text(
                            "Confirm Deletion",
                            style: TextStyle(color: Colors.black),
                          ),
                          content: Text(
                            'Are you sure you want to delete this product',
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                deleteInventoryProduct(
                                  productId,
                                ); // Delete booking
                                Navigator.pop(context); // Close dialog
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                  );
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
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
        color: color.withOpacity(0.2),
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
