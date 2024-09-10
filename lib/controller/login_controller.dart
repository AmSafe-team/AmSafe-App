import 'dart:convert';
import 'package:amsafe/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginWithEmail() async {
    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        throw "Email and password are required";
      }

      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.authEndpoints.loginEmail);
      Map<String, dynamic> body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };

      print('Login request body: ${jsonEncode(body)}');

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'SUCCESS' &&
            json['data'] != null &&
            json['data']['access'] != null) {
          final newToken = json['data']['access'];
          await _authService.setToken(newToken);
          emailController.clear();
          passwordController.clear();
          Get.off(() => MenuPage());
        } else {
          throw json['message'] ?? "Login failed: Unexpected response format";
        }
      } else if (response.statusCode == 401) {
        throw "Invalid email or password. Please check your credentials and try again.";
      } else {
        final errorJson = jsonDecode(response.body);
        throw errorJson['message'] ??
            "Login failed: Server error (${response.statusCode})";
      }
    } catch (e) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
