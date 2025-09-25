import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';
import 'package:frontend/features/auth/screens/signin_screen.dart';
import 'package:frontend/features/auth/services/authServices.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  String _selectedRole = 'Admin';
  String _selectedOption = ''; // initial selected value

  AuthService authService = AuthService();

  void signUpUser() {
    authService.signUpUser(
      context: context,
      name: _nameController.text,
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
            padding: const EdgeInsets.symmetric(vertical: 3),
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
                  height: 510,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  // padding: const EdgeInsets.all(20),
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
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Create Your Account",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                          focusNode: _nameFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
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
                          obscureText: true, // 👈 only here
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
                            decoration: const InputDecoration(
                              labelText: 'Role',
                            ),
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
                              setState(() {
                                _selectedRole = val!;
                              });
                            },
                          ),
                        ),
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
                            SizedBox(width: 5),
                            Text(
                              "By Proceeding futher , you agree to our Terms & Conditions",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CustomElevatedButton(
                          text: 'Create Account',
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                        ),
                        SizedBox(height: 18),
                        // Text(
                        //   "Or Login with",
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // SizedBox(height: 25),
                        // // Google and Apple Sign In Options
                        // OtherLoginOptions(),
                        SizedBox(height: 7),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Already Have An account? Login in ",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
