import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final _box = GetStorage();
  final user = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    user.value = _box.read('user');
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    var url = Uri.parse('https://besafe-app-server.vercel.app/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Store the email as our "token"
        await _box.write('user', email);
        user.value = email;
        Get.snackbar("Success", "Login successful");
      } else {
        Get.snackbar("Error", "Login failed. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password) async {
    isLoading.value = true;
    var url = Uri.parse('https://besafe-app-server.vercel.app/auth/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Registration successful");
        // Automatically log in after successful registration
        await login(email, password);
      } else {
        Get.snackbar("Error", "Registration failed. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _box.remove('user');
    user.value = null;
  }
}
