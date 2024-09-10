import 'package:amsafe/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amsafe/controller/auth_controller.dart';
import 'package:amsafe/pages/auth_page/login_page.dart';

class AuthGate extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.user.value != null) {
        return MenuPage();
      } else {
        return LoginPage();
      }
    });
  }
}
