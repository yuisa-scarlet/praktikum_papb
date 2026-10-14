import 'dart:convert';
import 'dart:io';

import 'package:praktikum_papb/model/post.dart';

class ApiService {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<dynamic> _get(String path) async {
    final client = HttpClient();

    try {
      final request = await client.getUrl(Uri.parse('$baseUrl/$path'));
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        return jsonDecode(body);
      } else {
        throw HttpException('Failed to load posts: ${response.statusCode}');
      }
    } finally {
      client.close();
    }
  }

  Future<dynamic> getPosts() async {
    final List data = await _get('posts');
    return data.map((item) => Post.fromJson(item)).toList();
  }
}