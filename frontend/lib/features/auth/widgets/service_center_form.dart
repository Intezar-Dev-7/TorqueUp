import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';

import 'package:frontend/features/admin/widgets/side_navigation_bar.dart';

class ServiceCenterForm extends StatefulWidget {
  const ServiceCenterForm({super.key});

  @override
  State<ServiceCenterForm> createState() => _ServiceCenterFormState();
}

class _ServiceCenterFormState extends State<ServiceCenterForm> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final FocusNode _businessNameFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _zipFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _businessNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();

    _businessNameFocus.dispose();
    _cityFocus.dispose();
    _stateFocus.dispose();
    _zipFocus.dispose();
    _countryFocus.dispose();
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
                        "Enter Your service Center Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _businessNameController,
                        hintText: 'Enter Business Name',
                        focusNode: _businessNameFocus,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: _cityController,
                        hintText: 'City',
                        focusNode: _cityFocus,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: _stateController,
                        hintText: 'State',
                        focusNode: _stateFocus,
                      ),

                      SizedBox(height: 10),
                      CustomTextField(
                        controller: _zipController,
                        hintText: 'ZIP/Postal Code ',
                        focusNode: _zipFocus,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: _countryController,
                        hintText: 'Country',
                        focusNode: _countryFocus,
                      ),
                      SizedBox(height: 10),
                      CustomElevatedButton(
                        text: 'Add',
                        onPressed: () {
                          Navigator.push(
                            context,
                            (MaterialPageRoute(
                              builder:
                                  (context) => SideNavigationBar(title: ''),
                            )),
                          );
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
