import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/widgets/app_bar.dart'
    show CustomAppBar;
import 'package:frontend/features/receptionist/widgets/dash_top_widget.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/constant.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final List<dynamic> list = [
    {'icon': GenIcons.money, 'title': 'Revenue', 'value': 6},
    {'icon': GenIcons.money, 'title': 'Revenue', 'value': 6},
    {'icon': GenIcons.money, 'title': 'Revenue', 'value': 6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // CustomAppBar(title: 'Dashboard'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder:
                (_, context) {
                  var icon = list[context]['icon'];
                  var title = list[context]['title'];
                  var value = int.parse(list[context]['value']);
                  return DashTopWidget(icon: icon, title: title, value: value);
                },
          ),
        ],
      ),
    );
  }
}
