import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';
import 'package:frontend/features/auth/screens/signup_screen.dart';
import 'package:frontend/features/auth/screens/forgot_password_screen.dart';
import 'package:frontend/features/auth/services/authServices.dart';

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

  String _selectedOption = ''; // initial selected value

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      role: _selectedRole,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: SafeArea(
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
                  height: 500,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2.5,
                        offset: const Offset(
                          0,
                          5,
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Login To Your Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
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
                      SizedBox(height: 10),
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
                      SizedBox(height: 10),
                      // Add a new textfield asking the user to enter his role
                      SizedBox(
                        height: 55,
                        width: 340,
                        child: DropdownButtonFormField<String>(
                          elevation: 2,
                          focusColor: Colors.black,
                          borderRadius: BorderRadius.circular(18),

                          initialValue: _selectedRole,
                          decoration: const InputDecoration(labelText: 'Role'),
                          items:
                              ['Admin', 'Receptionist', 'Customer']
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(s),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (val) {
                            _selectedRole = val!;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          Text(
                            "Remember me",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 112),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomElevatedButton(
                        text: 'login',
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            signInUser();
                          }
                        },
                      ),
                      // SizedBox(height: 20),
                      // Text(
                      //   "Or Login with",
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                      // // Google and Apple Sign In Options

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: Image.asset(
                      //         'assets/general_icons/google.png',
                      //         height: 30,
                      //         width: 30,
                      //       ),
                      //     ),

                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: Image.asset(
                      //         'assets/general_icons/apple.png',
                      //         height: 30,
                      //         width: 30,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(elevation: 2),

                        child: Text(
                          "Create Account ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
