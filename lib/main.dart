import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/database/app_database.dart';
import 'package:praktikum_papb/routes/app_pages.dart';
import 'package:praktikum_papb/service/api_service.dart';
import 'package:praktikum_papb/controller/post_controller.dart';
import 'package:praktikum_papb/service/auth_service.dart';

void main() {
  final apiService = ApiService();
  Get.put(AuthService(database: AppDatabase())); 
  Get.put(PostController(apiService: apiService)..loadPosts());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter API List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
