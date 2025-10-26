import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Inventory/services/inventory_services.dart';
import 'package:frontend/features/receptionist/Inventory/widgets/add_inventory_form.dart';
import 'package:frontend/features/receptionist/Inventory/widgets/edit_product_details_form.dart';
import 'package:frontend/features/receptionist/model/inventory_model.dart';
import 'package:frontend/utils/colors.dart';

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

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

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
        SnackBar(
          content: const Text("Unable to load inventory. Please try again."),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

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

  void _openAddInventoryForm() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: const AddInventoryForm(),
      ),
    ).then((_) => fetchProducts());
  }

  void _openEditProductForm(Inventory item) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: EditProductDetailsForm(
          productId: item.productId,
          productQuantity: item.productQuantity,
          productPrice: item.productPrice,
          productStatus: item.productStatus,
        ),
      ),
    ).then((_) => fetchProducts());
  }

  List<Inventory> get filteredInventory {
    if (searchQuery.isEmpty) return inventoryList;
    return inventoryList
        .where((item) =>
        item.productName.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.admin_bg,
      appBar: _buildModernAppBar(screenWidth),
      body: Padding(
        padding: EdgeInsets.all(isMobile(screenWidth) ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCards(screenWidth),
            const SizedBox(height: 24),
            _buildInventoryTable(screenWidth),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(double screenWidth) {
    return AppBar(
      toolbarHeight: isMobile(screenWidth) ? 140 : 120,
      backgroundColor: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.black.withOpacity(0.1),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.admin_primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.inventory_2_outlined,
                          color: AppColors.admin_primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Inventory Management',
                              style: TextStyle(
                                fontSize: isMobile(screenWidth) ? 18 : 22,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Manage stock, pricing, and availability',
                              style: TextStyle(
                                fontSize: isMobile(screenWidth) ? 12 : 14,
                                color: AppColors.text_grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                /*Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.admin_primary,
                        AppColors.admin_primary_light,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.admin_primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.transparent,
                      shadowColor: AppColors.transparent,
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: isMobile(screenWidth) ? 12 : 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _openAddInventoryForm,
                    child: isMobile(screenWidth)
                        ? Icon(Icons.add_rounded, color: AppColors.white)
                        : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_rounded, color: AppColors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Add Product',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.light_bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.border_grey.withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: AppColors.admin_primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        hintStyle: TextStyle(
                          color: AppColors.text_grey,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (query) {
                        setState(() => searchQuery = query);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(double screenWidth) {
    final totalValue = inventoryList.fold<int>(
      0,
          (sum, item) => sum + (item.productQuantity * item.productPrice),
    );

    if (isMobile(screenWidth)) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Products',
                  inventoryList.length,
                  Icons.inventory_2_outlined,
                  AppColors.admin_primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Low Stock',
                  inventoryList
                      .where((p) => p.productStatus == 'Low Stock')
                      .length,
                  Icons.warning_amber_rounded,
                  AppColors.status_pending,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Out of Stock',
                  inventoryList
                      .where((p) => p.productStatus == 'Out of Stock')
                      .length,
                  Icons.hourglass_bottom_outlined,
                  AppColors.error,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Total Value',
                  totalValue,
                  Icons.attach_money_outlined,
                  AppColors.status_completed,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildStatCard(
          'Total Products',
          inventoryList.length,
          Icons.inventory_2_outlined,
          AppColors.admin_primary,
        ),
        _buildStatCard(
          'Low Stock',
          inventoryList.where((p) => p.productStatus == 'Low Stock').length,
          Icons.warning_amber_rounded,
          AppColors.status_pending,
        ),
        _buildStatCard(
          'Out of Stock',
          inventoryList.where((p) => p.productStatus == 'Out of Stock').length,
          Icons.hourglass_bottom_outlined,
          AppColors.error,
        ),
        _buildStatCard(
          'Total Value',
          totalValue,
          Icons.attach_money_outlined,
          AppColors.status_completed,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.text_dark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: AppColors.text_grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryTable(double screenWidth) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.admin_primary.withOpacity(0.08),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Product Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.admin_primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Quantity',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.admin_primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Price',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.admin_primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.admin_primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Actions',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.admin_primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF00897B),
                ),
              ),
            )
                : filteredInventory.isEmpty
                ? Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: AppColors.text_grey.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No inventory items found',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.text_grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: filteredInventory.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: AppColors.border_grey.withOpacity(0.3),
                ),
                itemBuilder: (context, index) {
                  final item = filteredInventory[index];
                  return _buildProductRow(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductRow(Inventory item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.admin_primary.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: item.productImageBytes != null
                        ? MemoryImage(item.productImageBytes!)
                        : const NetworkImage('https://via.placeholder.com/40')
                    as ImageProvider,
                    backgroundColor: AppColors.admin_primary.withOpacity(0.1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.productName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.text_dark,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              item.productQuantity.toString(),
              style: TextStyle(
                color: AppColors.text_dark,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '₹${item.productPrice}',
              style: TextStyle(
                color: AppColors.text_dark,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildStatusChip(item.productStatus),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.status_completed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: AppColors.status_completed,
                    ),
                    onPressed: () => _openEditProductForm(item),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: AppColors.error,
                    ),
                    onPressed: () => _confirmDelete(item.productId),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'In Stock':
        color = AppColors.status_completed;
        break;
      case 'Low Stock':
        color = AppColors.status_pending;
        break;
      case 'Out of Stock':
        color = AppColors.error;
        break;
      default:
        color = AppColors.grey30;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  void _confirmDelete(String productId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Confirm Deletion",
                style: TextStyle(
                  color: AppColors.text_dark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this product? This action cannot be undone.',
          style: TextStyle(
            color: AppColors.text_dark,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: AppColors.text_grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                deleteInventoryProduct(productId);
                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
