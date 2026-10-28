import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/service/auth_service.dart';

class RegisterController extends GetxController {
  final AuthService _auth = Get.find();

  final formKey = GlobalKey<FormState>(); 
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      await _auth.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      Get.back();
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}