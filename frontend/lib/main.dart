import 'package:flutter/material.dart';
import 'package:frontend/admin_side_navigation_bar.dart';
import 'package:frontend/features/auth/screens/signin_screen.dart';
import 'package:frontend/features/auth/services/auth_services.dart';

import 'package:frontend/receptionist_side_nav_bar.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // important for async initialization

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  // @override
  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TorqueUp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: _getHomeScreen(userProvider),
    );
  }

  _getHomeScreen(UserProvider userProvider) {
    if (userProvider.user.token.isEmpty) {
      return const SignInScreen(); // Not logged in
    }

    if (userProvider.user.role == 'admin') {
      return const AdminSideNavigationBar(); // Admin home
    }

    if (userProvider.user.role == 'receptionist') {
      return const ReceptionistSideNavBar(); // Receptionist home
    }

    return const SignInScreen(); // Default fallback
  }
}
