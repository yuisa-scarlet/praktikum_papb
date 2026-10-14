import 'package:flutter/material.dart';
import 'package:praktikum_papb/enum/load_state.dart';
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
      home: PostListPage(postController: postController),
    );
  }
}

class PostListPage extends StatelessWidget {
  final PostController postController;

  const PostListPage({super.key, required this.postController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
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
                    title: Text(post.title),
                    subtitle: Text(post.body),
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
