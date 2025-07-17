import 'package:flutter/material.dart';

Future<void> showAddItemDialog(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  String itemName = '';
  int itemQuantity = 0;
  double itemPrice = 0.0;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 100, vertical: 80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(32),
          height: 500,
          width: 800, // Wider for web
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add New Inventory Item',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Form
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Item Name
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Item Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter item name'
                                        : null,
                            onSaved: (value) => itemName = value!,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Quantity
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator:
                                (value) =>
                                    value == null || int.tryParse(value) == null
                                        ? 'Enter valid quantity'
                                        : null,
                            onSaved:
                                (value) => itemQuantity = int.parse(value!),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Price
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Price',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            validator:
                                (value) =>
                                    value == null ||
                                            double.tryParse(value) == null
                                        ? 'Enter valid price'
                                        : null,
                            onSaved:
                                (value) => itemPrice = double.parse(value!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              // TODO: Add item to list or DB
                              print(
                                'Added: $itemName, Qty: $itemQuantity, Price: $itemPrice',
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Add Item'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
