import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_appbar.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: 'Dashboard'),
      body: Row(children: [
      
    ],),
    );
  }
}
