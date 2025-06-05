import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final Icon icon;
  final int value;
  const CustomContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 180,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white, // Add a background color
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Light shadow color
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(2, 2), // Soft offset
            ),
          ],
        ),
        child: Row(
          children: [
            icon, SizedBox(width: 10),

            // vertical divider line
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  '$value',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
