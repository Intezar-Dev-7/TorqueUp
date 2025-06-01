import 'package:flutter/material.dart';
import 'package:frontend/features/receptionist/screens/booking_screen.dart';
import 'package:frontend/features/receptionist/screens/customer_screen.dart';
import 'package:frontend/features/receptionist/screens/mechanics_screen.dart';
import 'package:frontend/features/receptionist/screens/services_screen.dart';

import 'features/receptionist/layout/mian_layout.dart';
import 'features/receptionist/screens/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(path: '/dashboard', builder: (_, __) => DashboardScreen()),
          GoRoute(path: '/bookings', builder: (_, __) => BookingScreen()),
          GoRoute(path: '/customers', builder: (_, __) => CustomerScreen()),
          GoRoute(path: '/services', builder: (_, __) => ServicesScreen()),
          GoRoute(path: '/mechanics', builder: (_, __) => MechanicsScreen()),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TorqueUp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}
