import 'dart:convert';
import 'package:amsafe/main.dart';
import 'package:amsafe/pages/auth_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? selectedState;

  Future<void> registerWithEmail() async {
    try {
      // Validate input fields
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          mobileNumberController.text.isEmpty) {
        throw "All fields are required";
      }

      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
        ApiEndpoints.baseUrl + ApiEndpoints.authEndpoints.registerEmail,
      );
      Map<String, dynamic> body = {
        'email': emailController.text.trim(),
        'name': nameController.text.trim(),
        'user_role': 2,
        'state': 104,
        'mobile_number': mobileNumberController.text.trim(),
        'password': passwordController.text,
      };

      print('Request body: ${jsonEncode(body)}');

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'SUCCESS') {
          clearControllers();
          Get.off(() => LoginPage());
        } else {
          throw json['message'] ?? "Unknown error occurred";
        }
      } else {
        final errorJson = jsonDecode(response.body);
        throw errorJson['message'] ?? "Unknown error occurred";
      }
    } catch (e) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Theme.of(context).mainColor,
            title: Text(
              'Message',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            contentPadding: EdgeInsets.all(20),
            children: [
              Text(
                e.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    mobileNumberController.clear();
  }
}
