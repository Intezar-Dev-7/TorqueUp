import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class CustomerCard extends StatelessWidget {
  final Map<String, String> customer;
  final bool isSelected;

  const CustomerCard({
    super.key,
    required this.customer,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
        boxShadow:
            isSelected
                ? []
                : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  customer['id']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.grey30,
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.grey30,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text('image'),
                ),
                Text.rich(
                  TextSpan(
                    text: customer['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: '\n${customer['phone']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer['email']!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      customer['address']!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  "Vehicles :- ${customer['vehicles']!}",
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
