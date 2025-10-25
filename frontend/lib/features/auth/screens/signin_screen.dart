import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';
import 'package:frontend/features/auth/screens/signup_screen.dart';
import 'package:frontend/features/auth/screens/forgot_password_screen.dart';
import 'package:frontend/features/auth/services/authServices.dart';
import 'package:frontend/utils/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  String _selectedRole = 'Admin';
  String _selectedOption = '';
  bool _rememberMe = false;

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      role: _selectedRole,
    );
  }

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 900;
  bool isDesktop(double width) => width >= 900;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Form(
            key: _formkey,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile(constraints.maxWidth) ? 20 : 40,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      _buildLogo(constraints.maxWidth),
                      SizedBox(
                          height: isMobile(constraints.maxWidth) ? 30 : 40),
                      // Login Form Card
                      _buildLoginCard(constraints.maxWidth),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo(double screenWidth) {
    double logoHeight;
    double logoWidth;

    if (isMobile(screenWidth)) {
      logoHeight = 120;
      logoWidth = 280;
    } else if (isTablet(screenWidth)) {
      logoHeight = 140;
      logoWidth = 320;
    } else {
      logoHeight = 160;
      logoWidth = 350;
    }

    return Image.asset(
      'assets/appLogo/TorqueUpLogo.png',
      height: logoHeight,
      width: logoWidth,
    );
  }

  Widget _buildLoginCard(double screenWidth) {
    double cardWidth;
    double cardPadding;

    if (isMobile(screenWidth)) {
      cardWidth = double.infinity;
      cardPadding = 20;
    } else if (isTablet(screenWidth)) {
      cardWidth = 500;
      cardPadding = 30;
    } else {
      cardWidth = 480;
      cardPadding = 35;
    }

    return Container(
      width: cardWidth,
      constraints: BoxConstraints(
        maxWidth: 550,
      ),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title with icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.sky_blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.sky_blue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Login To Your Account",
                style: TextStyle(
                  color: Color(0xFF2C3E50),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile(screenWidth) ? 24 : 28),

          // Email Field
          CustomTextField(
            controller: _emailController,
            hintText: 'Email',
            focusNode: _emailFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password Field
          CustomTextField(
            obscureText: true,
            controller: _passwordController,
            hintText: 'Password',
            focusNode: _passwordFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Role Dropdown
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              elevation: 2,
              value: _selectedRole,
              borderRadius: BorderRadius.circular(12),
              decoration: InputDecoration(
                labelText: 'Role',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.sky_blue,
                  size: 20,
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.sky_blue,
              ),
              items: ['Admin', 'Receptionist', 'Customer']
                  .map(
                    (s) => DropdownMenuItem(
                  value: s,
                  child: Text(
                    s,
                    style: const TextStyle(
                      color: Color(0xFF2C3E50),
                      fontSize: 14,
                    ),
                  ),
                ),
              )
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedRole = val!;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Remember Me & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      activeColor: AppColors.sky_blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Remember me",
                    style: TextStyle(
                      color: Color(0xFF2C3E50),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    color: AppColors.sky_blue,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile(screenWidth) ? 24 : 28),

          // Login Button
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.sky_blue, Color(0xFF29B6F6)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.sky_blue.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  signInUser();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile(screenWidth) ? 20 : 24),

          // Create Account Button
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.sky_blue.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Create Account",
                style: TextStyle(
                  color: AppColors.sky_blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
