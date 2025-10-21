import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';

import 'package:frontend/features/receptionist/Inventory/services/inventory_services.dart';
import 'package:frontend/features/receptionist/Inventory/widgets/add_inventory_form.dart';
import 'package:frontend/features/receptionist/Inventory/widgets/edit_product_details_form.dart';
import 'package:frontend/features/receptionist/model/inventory_model.dart';

class AdminInventoryScreen extends StatefulWidget {
  const AdminInventoryScreen({super.key});

  @override
  State<AdminInventoryScreen> createState() => _AdminInventoryScreenState();
}

class _AdminInventoryScreenState extends State<AdminInventoryScreen> {
  final InventoryServices inventoryServices = InventoryServices();
  List<Inventory> inventoryList = [];
  bool isLoading = true;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  /// Fetch all inventory products
  void fetchProducts() async {
    setState(() => isLoading = true);
    try {
      final fetchedInventory = await inventoryServices.fetchAllProducts(
        context: context,
      );
      if (!mounted) return;
      setState(() {
        inventoryList = fetchedInventory;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unable to load inventory. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Delete a product
  void deleteInventoryProduct(String productId) async {
    await inventoryServices.deleteProduct(
      context: context,
      productId: productId,
    );
    setState(() {
      inventoryList.removeWhere((item) => item.productId == productId);
    });
    fetchProducts();
  }

  /// Add new product
  void _openAddInventoryForm() {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            insetPadding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              child: const AddInventoryForm(),
            ),
          ),
    ).then((_) => fetchProducts());
  }

  /// Edit existing product
  void _openEditProductForm(Inventory item) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            insetPadding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              child: EditProductDetailsForm(
                productId: item.productId,
                productQuantity: item.productQuantity,
                productPrice: item.productPrice,
                productStatus: item.productStatus,
              ),
            ),
          ),
    ).then((_) => fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppbar(
        title: 'Inventory Management',
        subtitle: 'Admin access — manage stock, pricing, and availability',
        onPressed: _openAddInventoryForm,
        text: 'Add Product',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsRow(),
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
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child:
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : inventoryList.isEmpty
                        ? const Center(
                          child: Text(
                            'No inventory items found.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                        : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor: WidgetStateColor.resolveWith(
                              (_) => Colors.grey.shade200,
                            ), // grey header row
                            columnSpacing: 60,
                            columns: const [
                              DataColumn(label: Text('Product Name')),
                              DataColumn(label: Text('Quantity')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: inventoryList.map(_buildRow).toList(),
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Dashboard Summary cards
  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInventoryCard(
          title: 'Total Products',
          value: inventoryList.length,
          icon: Icons.inventory_2,
          color: Colors.blue,
        ),
        _buildInventoryCard(
          title: 'Low Stock',
          value:
              inventoryList.where((p) => p.productStatus == 'Low Stock').length,
          icon: Icons.warning_amber_rounded,
          color: Colors.orange,
        ),
        _buildInventoryCard(
          title: 'Out of Stock',
          value:
              inventoryList
                  .where((p) => p.productStatus == 'Out of Stock')
                  .length,
          icon: Icons.hourglass_empty,
          color: Colors.red,
        ),
        _buildInventoryCard(
          title: 'Total Value',
          value: inventoryList.fold<int>(
            0,
            (sum, item) => sum + (item.productQuantity * item.productPrice),
          ),
          icon: Icons.attach_money,
          color: Colors.green,
        ),
      ],
    );
  }

  /// Small reusable info card
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

  /// DataTable rows builder
  DataRow _buildRow(Inventory item) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    item.productImageBytes != null
                        ? MemoryImage(item.productImageBytes!)
                        : const NetworkImage('https://via.placeholder.com/40')
                            as ImageProvider,
              ),
              const SizedBox(width: 10),
              Text(
                item.productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(item.productQuantity.toString())),
        DataCell(Text('₹${item.productPrice.toString()}')),
        DataCell(_buildStatusChip(item.productStatus)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.green),
                onPressed: () => _openEditProductForm(item),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _confirmDelete(item.productId),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Confirm deletion popup
  void _confirmDelete(String productId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Confirm Deletion"),
            content: const Text(
              "Are you sure you want to delete this product?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  deleteInventoryProduct(productId);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
    );
  }

  /// Status badge
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
