import 'package:flutter/material.dart';
import 'package:praktikum_papb/enum/load_state.dart';
import 'package:praktikum_papb/controller/post_controller.dart';
import 'package:praktikum_papb/pages/post_detail_page.dart';

class PostListPage extends StatelessWidget {
  final PostController postController;

  const PostListPage({super.key, required this.postController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Json type code'),
      ),
      body: ListenableBuilder(
        listenable: postController,
        builder: (context, _) {
          switch (postController.loadState) {
            case LoadState.initial:
            case LoadState.loading:
              return const Center(child: CircularProgressIndicator());
            case LoadState.loaded:
              return ListView.builder(
                itemCount: postController.allPosts.length,
                itemBuilder: (context, index) {
                  final post = postController.allPosts[index];
                  return ListTile(
                    title: Text(
                      post.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(post.body),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:(context) => PostDetailPage(post: post),
                        ),
                      );
                    }
                  );
                },
              );
            case LoadState.error:
              return const Center(child: Text('Failed to load posts'));
          }
        }
      ),
    );
  }
}