// import 'package:flutter/material.dart';
// import 'package:frontend/common/widgets/custom_appbar.dart';

// class InventoryScreen extends StatefulWidget {
//   const InventoryScreen({super.key});

//   @override
//   State<InventoryScreen> createState() => _InventoryScreenState();
// }

// class _InventoryScreenState extends State<InventoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         title: 'Inventory',
//         subtitle: 'Manage your Inventory',
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';

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
      appBar: CustomAppbar(
        title: 'Inventory',
        subtitle: 'Manage your Inventory',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            // Search bar
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search items...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onChanged: (value) {
                  setState(() => searchQuery = value);
                },
              ),
            ),
            const SizedBox(width: 16),
            // Add Item button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Add item logic here
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Add Item",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Container(
                    width: 380,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
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
}
