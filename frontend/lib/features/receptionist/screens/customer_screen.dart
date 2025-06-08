import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

import '../data/dummy_data.dart';
import '../widgets/customer_card.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.grey,
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: AppColors.grey30),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by name, email address...',
                          hintStyle: TextStyle(color: AppColors.grey30),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.filter_list_outlined, color: AppColors.grey30),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Add Customer Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Add Customer",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer List
            Expanded(
              child: ListView.separated(
                itemCount: customers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final customer = customers[index];
                  return CustomerCard(
                    customer: customer,
                    isSelected: index == customers.length - 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
