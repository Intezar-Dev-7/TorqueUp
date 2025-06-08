import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Let's check your Garage today",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mail_outline),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.notifications_none),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            // Replace with your image
            backgroundImage: NetworkImage(
              "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
            ), // use NetworkImage if needed
          ),
          const SizedBox(width: 8),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cody Fisher",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text("Owner", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
