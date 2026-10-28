import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.submit,
                  child: controller.isLoading.value ? CircularProgressIndicator() : Text('Login'),
                )),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/register');
                  },
                  child: Text('Don\'t have an account? Register'),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}