import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/enum/load_state.dart';
import 'package:praktikum_papb/controller/post_controller.dart';
import 'package:praktikum_papb/routes/app_routes.dart';
import 'package:praktikum_papb/widgets/app_bottom_nav.dart';

class PostListPage extends GetView<PostController> {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Json type code'),
      ),
      body: Obx(() {
        switch (controller.loadState.value) {
          case LoadState.initial:
          case LoadState.loading:
            return const Center(child: CircularProgressIndicator());
          case LoadState.loaded:
            return ListView.builder(
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                final post = controller.posts[index];
                return ListTile(
                  title: Text(
                    post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(post.body),
                  onTap: () => Get.toNamed(AppRoutes.postDetailPath(post.id)),
                );
              },
            );
          case LoadState.error:
            return const Center(child: Text('Failed to load posts'));
        }
      }),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}