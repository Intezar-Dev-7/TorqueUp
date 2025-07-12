import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.searchText,
    required this.button,
  });
  final Widget button;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                      hintText: searchText,
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

        // Add Custom Button
        button,
      ],
    );
  }
}
