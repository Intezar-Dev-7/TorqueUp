import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String _selectedOption = ''; // initial selected value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15), // distance from top
                Center(
                  child: Image.asset(
                    'assets/appLogo/TorqueUpLogo.png',
                    height: 400,
                    width: 400,
                  ),
                ),
                Container(
                  width: 450,
                  height: 500,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        offset: const Offset(
                          0,
                          5,
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text(
                          "Login To Your Account",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                          focusNode: _emailFocusNode,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          focusNode: _passwordFocusNode,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Radio<String>(
                              value: '',
                              groupValue: _selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value!;
                                });
                              },
                            ),
                            SizedBox(width: 8),
                            Text("Remember me"),
                            SizedBox(width: 112),
                            TextButton(
                              onPressed: () {},
                              child: Text("Forgot Password ?"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
