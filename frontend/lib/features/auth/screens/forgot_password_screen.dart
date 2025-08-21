import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/appLogo/TorqueUpLogo.png',
                  height: 160,
                  width: 350,
                ),
              ),
              Container(
                width: 450,
                height: 350,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2.5,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Reset Your Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Enter email address ',
                        focusNode: _emailFocusNode,
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Back to Sign In",
                          style: TextStyle(fontSize: 18, color: Colors.black45),
                        ),
                      ),
                      SizedBox(height: 50),
                      CustomElevatedButton(
                        text: 'Send',
                        onPressed: () {
                          // Redirect to main signin Screen
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
