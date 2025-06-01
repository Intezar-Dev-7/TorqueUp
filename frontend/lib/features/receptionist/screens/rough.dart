import 'package:frontend/features/receptionist/layout/main_layout.dart';
import 'package:frontend/features/receptionist/screens/booking_screen.dart';
import 'package:frontend/features/receptionist/screens/customer_screen.dart';
import 'package:frontend/features/receptionist/screens/dashboard_screen.dart';
import 'package:frontend/features/receptionist/screens/mechanics_screen.dart';
import 'package:frontend/features/receptionist/screens/services_screen.dart';
import 'package:go_router/go_router.dart';

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
