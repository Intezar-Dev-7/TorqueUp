import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TodaysBookingWidget extends StatefulWidget {
  const TodaysBookingWidget({super.key});

  @override
  State<TodaysBookingWidget> createState() => _TodaysBookingWidgetState();
}

class _TodaysBookingWidgetState extends State<TodaysBookingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 265,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Iconsax.book_saved, color: Colors.lightGreenAccent),
                SizedBox(width: 8),
                const Text(
                  "Today's Booking",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 290),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See All",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
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
