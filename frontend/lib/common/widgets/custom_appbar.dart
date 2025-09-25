import 'package:flutter/material.dart';
import 'package:frontend/features/admin/widgets/notification_screen.dart';
import 'package:frontend/utils/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed; // Corrected
  final String text;
  const CustomAppbar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title and user info row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Title & Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                /// Notification + Profile
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminNotificationScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.notifications_none),
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Search Bar + Button
            Row(
              children: [
                /// Search bar container
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.filter_list_outlined,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                /// Action button (e.g., Add)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    minimumSize: const Size(100, 50),
                    backgroundColor: AppColors.black,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(170); // height includes search bar
}
