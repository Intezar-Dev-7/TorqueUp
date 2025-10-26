import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import 'package:frontend/features/receptionist/Inventory/services/inventory_services.dart';
import 'package:frontend/utils/colors.dart';

class AddInventoryForm extends StatefulWidget {
  const AddInventoryForm({super.key});

  @override
  State<AddInventoryForm> createState() => _AddInventoryFormState();
}

class _AddInventoryFormState extends State<AddInventoryForm> {
  final InventoryServices inventoryServices = InventoryServices();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productQuantityController =
  TextEditingController();
  final TextEditingController productPriceController = TextEditingController();

  String productStatus = 'In Stock';

  Uint8List? selectedImageBytes;
  String? selectedImageName;

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 900;
  bool isDesktop(double width) => width >= 900;

  @override
  void dispose() {
    productNameController.dispose();
    productQuantityController.dispose();
    productPriceController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedImageBytes = result.files.first.bytes;
        selectedImageName = result.files.first.name;
      });
    }
  }

  void addProductToInventory() async {
    await inventoryServices.addProducts(
      context: context,
      productName: productNameController.text,
      productQuantity: int.tryParse(productQuantityController.text) ?? 0,
      productPrice: int.tryParse(productPriceController.text) ?? 0,
      productStatus: productStatus,
      productImageBytes: selectedImageBytes,
      productImageName: selectedImageName,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = isMobile(screenWidth);

        return Material(
          type: MaterialType.transparency,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isSmallScreen ? screenWidth * 0.95 : 700,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            padding: EdgeInsets.all(isSmallScreen ? 20 : 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with Icon
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.sky_blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.add_box_outlined,
                            color: AppColors.sky_blue,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "Add Inventory",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 20 : 24,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text_dark,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close_rounded,
                            color: AppColors.text_grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 28),

                    // Product Name
                    _buildTextField(
                      controller: productNameController,
                      label: "Product Name",
                      icon: Icons.inventory_2_outlined,
                      validator: (val) =>
                      val == null || val.isEmpty
                          ? "Enter product name"
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Quantity and Price in Row for larger screens
                    if (!isSmallScreen)
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: productQuantityController,
                              label: "Quantity",
                              icon: Icons.format_list_numbered_outlined,
                              keyboardType: TextInputType.number,
                              validator: (val) =>
                              val == null || val.isEmpty
                                  ? "Enter quantity"
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              controller: productPriceController,
                              label: "Price",
                              icon: Icons.attach_money_outlined,
                              keyboardType: TextInputType.number,
                              validator: (val) =>
                              val == null || val.isEmpty
                                  ? "Enter price"
                                  : null,
                            ),
                          ),
                        ],
                      )
                    else ...[
                      _buildTextField(
                        controller: productQuantityController,
                        label: "Quantity",
                        icon: Icons.format_list_numbered_outlined,
                        keyboardType: TextInputType.number,
                        validator: (val) =>
                        val == null || val.isEmpty
                            ? "Enter quantity"
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: productPriceController,
                        label: "Price",
                        icon: Icons.attach_money_outlined,
                        keyboardType: TextInputType.number,
                        validator: (val) =>
                        val == null || val.isEmpty ? "Enter price" : null,
                      ),
                    ],
                    const SizedBox(height: 16),

                    // Status Dropdown
                    _buildStatusDropdown(),
                    const SizedBox(height: 20),

                    // Image Upload Section
                    _buildImageUploadSection(),
                    SizedBox(height: isSmallScreen ? 24 : 32),

                    // Action Buttons
                    if (!isSmallScreen)
                      Row(
                        children: [
                          Expanded(child: _buildCancelButton()),
                          const SizedBox(width: 16),
                          Expanded(child: _buildSaveButton()),
                        ],
                      )
                    else ...[
                      _buildSaveButton(),
                      const SizedBox(height: 12),
                      _buildCancelButton(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border_grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          color: AppColors.text_dark,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.text_grey,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.sky_blue,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border_grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: productStatus,
        dropdownColor: AppColors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        decoration: InputDecoration(
          labelText: 'Status',
          labelStyle: TextStyle(
            color: AppColors.text_grey,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.flag_outlined,
            color: AppColors.sky_blue,
            size: 20,
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.sky_blue,
        ),
        items: ['In Stock', 'Low Stock', 'Out Of Stock']
            .map(
              (s) => DropdownMenuItem(
            value: s,
            child: Text(
              s,
              style: TextStyle(
                color: AppColors.text_dark,
                fontSize: 14,
              ),
            ),
          ),
        )
            .toList(),
        onChanged: (val) {
          setState(() {
            productStatus = val!;
          });
        },
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border_grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.image_outlined,
                color: AppColors.sky_blue,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Product Image',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.text_dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.sky_blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.sky_blue.withOpacity(0.3),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: selectedImageBytes != null
                ? Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    selectedImageBytes!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  selectedImageName ?? 'Image selected',
                  style: TextStyle(
                    color: AppColors.text_grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: pickImage,
                  icon: Icon(Icons.refresh, color: AppColors.sky_blue),
                  label: Text(
                    'Change Image',
                    style: TextStyle(color: AppColors.sky_blue),
                  ),
                ),
              ],
            )
                : InkWell(
              onTap: pickImage,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 48,
                      color: AppColors.sky_blue,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Click to upload product image',
                      style: TextStyle(
                        color: AppColors.text_dark,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'PNG, JPG up to 10MB',
                      style: TextStyle(
                        color: AppColors.text_grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
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
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            addProductToInventory();
          }
        },
        icon: Icon(Icons.save_outlined, color: AppColors.white, size: 20),
        label: Text(
          "Add Product",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.sky_blue.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: TextButton.icon(
        onPressed: () => Navigator.pop(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(Icons.close_rounded, color: AppColors.sky_blue, size: 20),
        label: Text(
          "Cancel",
          style: TextStyle(
            color: AppColors.sky_blue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
