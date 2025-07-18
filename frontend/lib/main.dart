import 'package:flutter/material.dart';
import 'package:frontend/features/admin/widgets/side_navigation_bar.dart';
import 'package:frontend/features/auth/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
        useMaterial3: true,
      ),
      home: LoginScreen(),
      // home: SideNavigationBar(),
      // home: ReceptionistMainScreen(),
    );
  }
}
