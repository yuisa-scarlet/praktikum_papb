import 'package:flutter/material.dart';
import 'package:praktikum_papb/pages/main_page.dart';
import 'package:praktikum_papb/service/api_service.dart';
import 'package:praktikum_papb/controller/post_controller.dart';

void main() {
  final apiService = ApiService();
  final postController = PostController(apiService: apiService)..loadPosts();

  runApp(MyApp(postController: postController));
}

class MyApp extends StatelessWidget {
  final PostController postController;

  const MyApp({ super.key, required this.postController });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainPage(postController: postController),
    );
  }
}
