import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:praktikum_papb/config/app_config.dart';
import 'package:praktikum_papb/model/post.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiService {
  static const _timeout = Duration(seconds: 15);

  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> _get(String path) async {
    final uri = Uri.parse('${AppConfig.baseUrl}/$path');
    final response = await _client.get(uri).timeout(_timeout);

    if (response.statusCode != 200) {
      throw ApiException(
        'Request to /$path failed: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }
    return jsonDecode(response.body);
  }

  Future<List<Post>> getPosts() async {
    final data = await _get('posts') as List<dynamic>;
    return data
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
