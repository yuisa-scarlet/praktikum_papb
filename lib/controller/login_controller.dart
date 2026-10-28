import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/routes/app_routes.dart';
import 'package:praktikum_papb/service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _auth = Get.find();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;

  @override
  void onInit() {
    super.onInit();

    final email = Get.arguments;
    if (email is String) {
      emailController.text = email;
    }
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      await _auth.login(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAllNamed(AppRoutes.home);
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}