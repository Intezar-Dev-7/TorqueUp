import 'package:flutter/material.dart';
import 'package:frontend/admin_side_navigation_bar.dart';
import 'package:frontend/features/auth/screens/signin_screen.dart';
import 'package:frontend/features/auth/services/auth_services.dart';
import 'package:frontend/receptionist_side_nav_bar.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/splashScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

// -------------------------------------------------------
//  THIS WRAPPER HANDLES SPLASH + AUTH + ROLE-ROUTING
// -------------------------------------------------------
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

    // Keep the splash visible while user data loads
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

    // AFTER splash → route based on login + role
    return _getHomeScreen(userProvider);
  }

  Widget _getHomeScreen(UserProvider userProvider) {
    if (userProvider.user.token.isEmpty) {
      return const SignInScreen();
    }

    if (userProvider.user.role == 'admin') {
      return const AdminSideNavigationBar();
    }

    if (userProvider.user.role == 'receptionist') {
      return const ReceptionistSideNavBar();
    }

    return const SignInScreen();
  }
}

// -------------------------------------------------------
//                 MAIN APP WIDGET
// -------------------------------------------------------
class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(
      context: context,
    ); // load user before splash finishes
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
      // IMPORTANT!!
      home: SplashWrapper(userProvider: userProvider),
    );
  }
}
