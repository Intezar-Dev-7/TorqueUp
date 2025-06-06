import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/constant.dart';

class DashTopWidget extends StatelessWidget {
  String icon;
  String title;
  int value;

  DashTopWidget({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
        children: [
          Image(image: AssetImage(icon), width: 200),
          Divider(color: Colors.grey, thickness: 1),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                value.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
