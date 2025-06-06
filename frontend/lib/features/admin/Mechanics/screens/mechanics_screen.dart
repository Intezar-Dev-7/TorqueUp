import 'package:flutter/material.dart';

class MechanicsScreen extends StatefulWidget {
  const MechanicsScreen({super.key});

  @override
  State<MechanicsScreen> createState() => _MechanicsScreenState();
}

class _MechanicsScreenState extends State<MechanicsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Mechanics"));
  }
}