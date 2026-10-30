import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/service/auth_service.dart';
import 'package:praktikum_papb/routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthService>();
    
    // null is can continue, otherwise redirect to login
    return auth.isLoggedIn ? null : const RouteSettings(name: AppRoutes.login);
  }
}