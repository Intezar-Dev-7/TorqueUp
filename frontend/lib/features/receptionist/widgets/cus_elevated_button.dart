import 'package:flutter/material.dart';

import '../../../utils/colors.dart' show AppColors;

class CusElevatedButton extends StatelessWidget {
  const CusElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024; // Tablet
    final bool isDesktop = screenWidth >= 1024; // Desktop
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.black,
        padding: isDesktop || isTablet ?  EdgeInsets.symmetric(horizontal: 18, vertical: 16) : EdgeInsets.symmetric(vertical: 6,horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child:
          isDesktop
              ? Text(
                buttonText,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
              : isTablet
              ? Text(
                buttonText.split(" ").first,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
              : Icon(Icons.add, color: AppColors.white, size: 30),
    );
  }
}
