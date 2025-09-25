import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import 'package:frontend/features/receptionist/Inventory/services/inventory_services.dart';

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
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Center(
        child: Container(
          height: mediaQuery.size.height * 0.7,
          width: mediaQuery.size.width * 0.7,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Add Inventory",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Product Name
                  TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      hintText: "Product Name",
                      prefixIcon: const Icon(Icons.inventory_2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter product name"
                                : null,
                  ),
                  const SizedBox(height: 20),

                  // Quantity
                  TextFormField(
                    controller: productQuantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Quantity",
                      prefixIcon: const Icon(Icons.format_list_numbered),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter quantity"
                                : null,
                  ),
                  const SizedBox(height: 20),

                  // Price
                  TextFormField(
                    controller: productPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Price",
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty ? "Enter price" : null,
                  ),
                  const SizedBox(height: 20),

                  // Status Dropdown
                  DropdownButtonFormField<String>(
                    initialValue: productStatus,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    items:
                        ['In Stock', 'Low Stock', 'Out Of Stock']
                            .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                    onChanged: (val) {
                      setState(() {
                        productStatus = val!;
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  // Upload product image // Optional
                  // Upload Image Button
                  ElevatedButton.icon(
                    onPressed: pickImage,
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload Product Image"),
                  ),

                  if (selectedImageBytes != null) ...[
                    const SizedBox(height: 10),
                    Image.memory(selectedImageBytes!, height: 120),
                  ],
                  const SizedBox(height: 25),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
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
                          child: const Text(
                            "Add Inventory",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
