import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/controller/post_controller.dart';
import 'package:praktikum_papb/enum/load_state.dart';

class PostDetailPage extends GetView<PostController> {
  final int? postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    // Reactive because a notification tap can open this page before the posts finish loading.
    return Obx(() {
      final state = controller.loadState.value;
      final post = postId == null ? null : controller.findById(postId!);

      if (post == null &&
          (state == LoadState.initial || state == LoadState.loading)) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      if (post == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('Post not found')),
          body: const Center(child: Text('Post not found')),
        );
      }

      return Scaffold(
        appBar: AppBar(title: Text(post.title)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(post.body),
        ),
      );
    });
  }
}
