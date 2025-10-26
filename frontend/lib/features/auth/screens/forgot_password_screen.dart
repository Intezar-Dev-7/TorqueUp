import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';
import 'package:frontend/features/auth/screens/signin_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
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
          return SafeArea(
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
                    SizedBox(height: isMobile(constraints.maxWidth) ? 30 : 40),
                    // Forgot Password Card
                    _buildForgotPasswordCard(constraints.maxWidth),
                  ],
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

  Widget _buildForgotPasswordCard(double screenWidth) {
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
      constraints: BoxConstraints(maxWidth: 550),
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
                  color: const Color(0xFF4FC3F7).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.lock_reset_rounded,
                  color: Color(0xFF4FC3F7),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Reset Your Password",
                style: TextStyle(
                  color: Color(0xFF2C3E50),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile(screenWidth) ? 16 : 20),

          // Info text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Enter your email address and we'll send you a link to reset your password.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: isMobile(screenWidth) ? 24 : 28),

          // Email Field
          CustomTextField(
            controller: _emailController,
            hintText: 'Enter email address',
            focusNode: _emailFocusNode,
          ),
          SizedBox(height: isMobile(screenWidth) ? 20 : 24),

          // Send Button
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4FC3F7).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // Send reset password email logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Send Reset Link',
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

          // Back to Sign In Button
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF4FC3F7).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => SignInScreen()),
                );
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF4FC3F7),
                size: 20,
              ),
              label: const Text(
                "Back to Sign In",
                style: TextStyle(
                  color: Color(0xFF4FC3F7),
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
