import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';
import 'package:frontend/features/auth/screens/login_screen.dart';
import 'package:frontend/features/auth/widgets/service_center_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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

  String _selectedOption = ''; // initial selected value
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
                height: 500,
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
                      ),
                      SizedBox(height: 10),
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
                      // Add a new textfield asking the user to enter his role
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
                          Navigator.push(
                            context,
                            (MaterialPageRoute(
                              builder: (context) => ServiceCenterForm(),
                            )),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Or Login with",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 27),
                      // Google and Apple Sign In Options
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/general_icons/google.png',
                              height: 30,
                              width: 30,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/general_icons/apple.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
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
    );
  }
}
