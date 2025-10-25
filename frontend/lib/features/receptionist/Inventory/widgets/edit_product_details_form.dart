import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/Inventory/services/inventory_services.dart';

class EditProductDetailsForm extends StatefulWidget {
  final String productId;
  final int productQuantity;
  final int productPrice;
  final String productStatus;

  const EditProductDetailsForm({
    super.key,
    required this.productId,
    required this.productQuantity,
    required this.productPrice,
    required this.productStatus,
  });

  @override
  State<EditProductDetailsForm> createState() => _EditProductDetailsFormState();
}

class _EditProductDetailsFormState extends State<EditProductDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  String productStatus = 'In Stock';
  late TextEditingController productQuantityController;
  late TextEditingController productPriceController;

  @override
  void initState() {
    super.initState();
    productQuantityController = TextEditingController(
      text: widget.productQuantity.toString(),
    );
    productPriceController = TextEditingController(
      text: widget.productPrice.toString(),
    );
    productStatus = widget.productStatus;
  }

  @override
  void dispose() {
    productQuantityController.dispose();
    productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // Quantity , price and status
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
                    // initialValue: productStatus,
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
                              if (_formKey.currentState!.validate()) {
                                final updatedQuantity = int.parse(
                                  productQuantityController.text,
                                );
                                final updatedPrice = int.parse(
                                  productPriceController.text,
                                );

                                // Call your update service here
                                InventoryServices().updateInventoryProduct(
                                  context: context,
                                  productId: widget.productId,
                                  productQuantity: updatedQuantity,
                                  productPrice: updatedPrice,
                                  productStatus: productStatus,
                                );

                                Navigator.pop(
                                  context,
                                ); // Close the dialog after save
                              }
                            }
                          },
                          child: const Text(
                            "Update",
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
