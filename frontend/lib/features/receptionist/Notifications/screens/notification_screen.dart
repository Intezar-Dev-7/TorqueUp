import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../admin/data/dummy_data.dart';

class ReceptionistSettingsScreen extends StatelessWidget {
  const ReceptionistSettingsScreen({super.key});

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
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              height: 45,
              width: 100,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.filter_list_outlined,
                    color: AppColors.grey30,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Filter",
                    style: TextStyle(color: AppColors.grey30, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notification_data.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.grey,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(right: 12.0),
                  decoration: BoxDecoration(
                    color: AppColors.grey30,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    Icons.receipt_rounded,
                    size: 18,
                    color: AppColors.grey,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification_data[index]['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        notification_data[index]['type'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        notification_data[index]['desc'],
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Text(notification_data[index]['time']),
              ],
            ),
          );
        },
      ),
    );
  }
}
