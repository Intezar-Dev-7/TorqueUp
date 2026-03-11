import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // A reusable dot widget
  Widget animatedDot(int index) {
    return FadeTransition(
      opacity: Tween(begin: 0.2, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(index * 0.2, 1.0)),
      ),
      child: Container(
        width: 12,
        height: 12,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive multiplier based on screen width
          double width = constraints.maxWidth;

          // Title size
          double fontSize =
              width < 500
                  ? 40
                  : // Mobile
                  width < 1000
                  ? 60
                  : // Tablet
                  80; // Laptop / Desktop

          // Spacing
          double spacing =
              width < 500
                  ? 20
                  : // Mobile
                  width < 1000
                  ? 30
                  : // Tablet
                  40; // Laptop / Desktop

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App Name
                Text(
                  "TorqueUp",
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: spacing),

                // Animated Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    animatedDot(0),
                    SizedBox(width: spacing / 2),
                    animatedDot(1),
                    SizedBox(width: spacing / 2),
                    animatedDot(2),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
