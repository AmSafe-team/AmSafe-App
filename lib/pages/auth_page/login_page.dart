import 'package:amsafe/controller/auth_controller.dart';
import 'package:amsafe/pages/auth_page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            Obx(() => authController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      authController.login(
                          emailController.text, passwordController.text);
                    },
                    child: const Text('Login'),
                  )),
            TextButton(
              onPressed: () {
                Get.to(() => SignupPage());
              },
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
