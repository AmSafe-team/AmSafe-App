import 'package:amsafe/controller/signup_controller.dart';
import 'package:amsafe/main.dart';
import 'package:amsafe/pages/auth_page/login_page.dart';
import 'package:amsafe/widget/app_auth_button.dart';
import 'package:amsafe/widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupController registerationController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Text(
                    'Welcome to Embassy!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                AppTextfield(
                  label: "name",
                  controller: registerationController.nameController,
                  obscureText: false,
                ),
                SizedBox(height: 10),
                AppTextfield(
                  label: "email",
                  controller: registerationController.emailController,
                  obscureText: false,
                ),
                SizedBox(height: 10),
                AppTextfield(
                  label: "address",
                  controller: registerationController.addressController,
                  obscureText: false,
                ),
                SizedBox(height: 10),
                AppTextfield(
                  label: "phone",
                  controller: registerationController.mobileNumberController,
                  obscureText: false,
                ),
                SizedBox(height: 10),
                //! Implement a dropdown for state selection
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "country",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                      ),
                      value: registerationController.selectedState,
                      onChanged: (String? newValue) {
                        setState(() {
                          registerationController.selectedState = newValue;
                        });
                      },
                      items: <String>['Alabaster - Alabama', 'Other states...']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                AppAuthButton(
                  onTap: () {
                    registerationController.registerWithEmail();
                  },
                  text: "Create Account",
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => LoginPage());
                      },
                      child: Text(
                        "Click here to login.",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
