import 'package:flutter/material.dart';
import 'package:frontend/admin_side_navigation_bar.dart';
import 'package:frontend/features/admin/data/provider/admin_setting_provider.dart';
import 'package:frontend/features/admin/data/provider/analytics_provider.dart';
import 'package:frontend/features/auth/data/provider/auth_provider.dart';
import 'package:frontend/features/auth/screens/signin_screen.dart';
import 'package:frontend/features/receptionist/data/provider/booking_provider.dart';
import 'package:frontend/features/receptionist/data/provider/inventory_provider.dart';
import 'package:frontend/features/receptionist/data/provider/receptionist_settings_provider.dart';
import 'package:frontend/features/receptionist/data/provider/receptionist_staff_provider.dart';
import 'package:frontend/receptionist_side_nav_bar.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/service_locator.dart';
import 'package:frontend/splashScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); // Initialize GetIt
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        // ADD YOUR NEW PROVIDER HERE
        ChangeNotifierProvider(create: (context) => AuthProvider()),

        ChangeNotifierProvider(create: (context) => BookingProvider()),

        ChangeNotifierProvider(create: (context) => AdminSettingsProvider()),

        ChangeNotifierProvider(create: (context) => InventoryProvider()),

        ChangeNotifierProvider(create: (context) => ReceptionistSettingsProvider()),

        ChangeNotifierProvider(create: (context) => ReceptionistStaffProvider()),

        ChangeNotifierProvider(create: (context) => AnalyticsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class SplashWrapper extends StatefulWidget {
  final UserProvider userProvider;
  const SplashWrapper({super.key, required this.userProvider});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  bool showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => showSplash = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = widget.userProvider;

    if (showSplash) {
      return const SplashScreen();
    }

    return _getHomeScreen(userProvider);
  }

  Widget _getHomeScreen(UserProvider userProvider) {
    if (userProvider.user.token.isEmpty) {
      return const SignInScreen();
    }
    if (userProvider.user.role.toLowerCase() == 'admin') {
      return const AdminSideNavigationBar();
    }
    if (userProvider.user.role.toLowerCase() == 'receptionist') {
      return const ReceptionistSideNavBar();
    }
    return const SignInScreen();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Safely call the provider after the first frame builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).getUserData(context: context);
    });
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
      home: SplashWrapper(userProvider: userProvider),
    );
  }
}