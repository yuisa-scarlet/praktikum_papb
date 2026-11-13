import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:praktikum_papb/service/api_service.dart';

void main() {
  test('getPosts parses the response into Post objects', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/posts');
      return http.Response(
        '[{"userId": 1, "id": 7, "title": "Hello", "body": "World"}]',
        200,
      );
    });

    final posts = await ApiService(client: client).getPosts();

    expect(posts, hasLength(1));
    expect(posts.first.id, 7);
    expect(posts.first.title, 'Hello');
  });

  test('getPosts throws ApiException on non-200 status', () async {
    final client = MockClient((_) async => http.Response('Not found', 404));

    expect(
      ApiService(client: client).getPosts(),
      throwsA(isA<ApiException>().having((e) => e.statusCode, 'statusCode', 404)),
    );
  });
}
