import 'package:flutter/material.dart';

class InventoryAlertWidget extends StatefulWidget {
  const InventoryAlertWidget({super.key});

  @override
  State<InventoryAlertWidget> createState() => _InventoryAlertWidgetState();
}

class _InventoryAlertWidgetState extends State<InventoryAlertWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 265,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(2, 2),
          ),
        ],
      ),
    );
  }
}
