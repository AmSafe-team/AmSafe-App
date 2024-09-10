import 'package:amsafe/controller/login_controller.dart';
import 'package:amsafe/main.dart';
import 'package:amsafe/pages/auth_page/signup_page.dart';
import 'package:amsafe/widget/app_auth_button.dart';
import 'package:amsafe/widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  LoginController loginController = Get.put(LoginController());

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
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Login to Embassy!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                //! email address
                AppTextfield(
                  controller: loginController.emailController,
                  label: "email",
                  obscureText: false,
                ),
                SizedBox(height: 20),
                //! password field
                AppTextfield(
                  controller: loginController.passwordController,
                  label: "password",
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      //! Handle forgot password
                    },
                    child: Text(
                      'Forgot password? Click here to reset.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                //! login button
                AppAuthButton(
                  onTap: () {
                    loginController.loginWithEmail();
                  },
                  text: "login",
                ),
                SizedBox(height: 16),
                //! move to sign up page
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to embassy? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SignupPage());
                      },
                      child: Text(
                        "Click here to sign up.",
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
