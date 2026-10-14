import 'package:flutter/material.dart';
import 'package:praktikum_papb/model/post.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail ${widget.post.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(widget.post.body),
      ),
    );
  }
}