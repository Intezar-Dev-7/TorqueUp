import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:frontend/features/admin/widgets/side_navigation_bar.dart';
import 'package:frontend/features/receptionist/Dashboard/screens/receptionist_main.dart';
=======
>>>>>>> 74f401649530b7ac15cd560fedc76f62c4519cf5
import 'package:google_fonts/google_fonts.dart';
import 'features/receptionist/Dashboard/screens/receptionist_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TorqueUp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: SideNavigationBar(),
    );
  }
}
