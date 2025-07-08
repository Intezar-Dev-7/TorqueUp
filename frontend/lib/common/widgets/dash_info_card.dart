import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class DashInfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final int value;
  final double iconSize;
  final double titleSize;
  final double valueSize;

  const DashInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.iconSize = 30,
    this.titleSize = 14,
    this.valueSize = 26,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(icon, width: iconSize),
          const SizedBox(width: 4),
          VerticalDivider(
            color: AppColors.grey30,
            thickness: 2,
            endIndent: 5,
            indent: 5,
          ),
          const SizedBox(width: 4),
          22 == iconSize
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: valueSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: valueSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
