import 'package:flutter/material.dart';

class MechanicsAvailabilityWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            offset: Offset(2, 2),
          ),
        ],
      ),
    );
  }
}
