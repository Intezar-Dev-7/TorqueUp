import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Inventory/services/inventory_services.dart';
import 'package:frontend/features/receptionist/Inventory/widgets/add_inventory_form.dart';
import 'package:frontend/features/receptionist/Inventory/widgets/edit_product_details_form.dart';
import 'package:frontend/features/receptionist/model/inventory_model.dart';
import 'package:frontend/utils/colors.dart';

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

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

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
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: const AddInventoryForm(),
        );
      },
    ).then((_) {
      setState(() {
        isLoading = true;
      });
      fetchProducts();
    });
  }

  void _editInventoryProductsForm(
    BuildContext context, {
    required String productId,
    required int productQuantity,
    required int productPrice,
    required String productStatus,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: EditProductDetailsForm(
            productId: productId,
            productQuantity: productQuantity,
            productPrice: productPrice,
            productStatus: productStatus,
          ),
        );
      },
    ).then((_) {
      setState(() {
        isLoading = true;
      });
      fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.sky_blue_bg,
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
                          color: AppColors.sky_blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.inventory_2_outlined,
                          color: AppColors.sky_blue,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Inventory',
                              style: TextStyle(
                                fontSize: isMobile(screenWidth) ? 18 : 22,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Manage your inventory',
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
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.sky_blue, AppColors.sky_blue_light],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.sky_blue.withOpacity(0.3),
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
                    onPressed: () => _openInventoryBookingForm(context),
                    child:
                        isMobile(screenWidth)
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(double screenWidth) {
    if (isMobile(screenWidth)) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildInventoryCard(
                  title: 'Total Products',
                  value: inventoryList.length,
                  icon: Icons.inventory_2_outlined,
                  color: AppColors.sky_blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInventoryCard(
                  title: 'Low Stock',
                  value:
                      inventoryList
                          .where((item) => item.productStatus == 'Low Stock')
                          .length,
                  icon: Icons.warning_amber_rounded,
                  color: AppColors.status_pending,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInventoryCard(
                  title: 'Out of Stock',
                  value:
                      inventoryList
                          .where((item) => item.productStatus == 'Out of Stock')
                          .length,
                  icon: Icons.hourglass_bottom_outlined,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInventoryCard(
                  title: 'Total Value',
                  value: inventoryList.fold(
                    0,
                    (sum, item) => sum + item.productPrice,
                  ),
                  icon: Icons.attach_money_outlined,
                  color: AppColors.status_completed,
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
        _buildInventoryCard(
          title: 'Total Products',
          value: inventoryList.length,
          icon: Icons.inventory_2_outlined,
          color: AppColors.sky_blue,
        ),
        _buildInventoryCard(
          title: 'Low Stock',
          value:
              inventoryList
                  .where((item) => item.productStatus == 'Low Stock')
                  .length,
          icon: Icons.warning_amber_rounded,
          color: AppColors.status_pending,
        ),
        _buildInventoryCard(
          title: 'Out of Stock',
          value:
              inventoryList
                  .where((item) => item.productStatus == 'Out of Stock')
                  .length,
          icon: Icons.hourglass_bottom_outlined,
          color: AppColors.error,
        ),
        _buildInventoryCard(
          title: 'Total Value',
          value: inventoryList.fold(0, (sum, item) => sum + item.productPrice),
          icon: Icons.attach_money_outlined,
          color: AppColors.status_completed,
        ),
      ],
    );
  }

  Widget _buildInventoryCard({
    required String title,
    required int value,
    required IconData icon,
    required Color color,
  }) {
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
                color: AppColors.sky_blue.withOpacity(0.08),
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
                        color: AppColors.sky_blue,
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
                        color: AppColors.sky_blue,
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
                        color: AppColors.sky_blue,
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
                        color: AppColors.sky_blue,
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
                        color: AppColors.sky_blue,
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
                    child: CircularProgressIndicator(color: Color(0xFF4FC3F7)),
                  ),
                )
                : inventoryList.isEmpty
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
                    itemCount: inventoryList.length,
                    separatorBuilder:
                        (context, index) => Divider(
                          height: 1,
                          color: AppColors.border_grey.withOpacity(0.3),
                        ),
                    itemBuilder: (context, index) {
                      final item = inventoryList[index];
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
                      color: AppColors.sky_blue.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage:
                        item.productImageBytes != null
                            ? MemoryImage(item.productImageBytes!)
                            : const NetworkImage(
                                  'https://via.placeholder.com/40',
                                )
                                as ImageProvider,
                    backgroundColor: AppColors.sky_blue.withOpacity(0.1),
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
              style: TextStyle(color: AppColors.text_dark, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '\$${item.productPrice.toDouble().toStringAsFixed(2)}',
              style: TextStyle(
                color: AppColors.text_dark,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(flex: 1, child: _buildStatusChip(item.productStatus)),
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
                    onPressed:
                        () => _editInventoryProductsForm(
                          context,
                          productId: item.productId,
                          productQuantity: item.productQuantity,
                          productPrice: item.productPrice,
                          productStatus: item.productStatus,
                        ),
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
                    onPressed: () => _showDeleteDialog(item.productId),
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
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
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

  void _showDeleteDialog(String productId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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
              style: TextStyle(color: AppColors.text_dark, fontSize: 14),
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
