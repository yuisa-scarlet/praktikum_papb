import 'package:flutter/material.dart';
import 'package:praktikum_papb/enum/load_state.dart';
import 'package:praktikum_papb/model/post.dart';
import 'package:praktikum_papb/service/api_service.dart';

class PostController extends ChangeNotifier {
  final ApiService apiService;
  PostController({required this.apiService});

  List<Post> _posts = [];
  LoadState _loadState = LoadState.initial;
  String _errorMessage = '';

  List<Post> get allPosts => _posts;
  LoadState get loadState => _loadState;
  String get errorMessage => _errorMessage;

  Future<void> loadPosts() async {
    _loadState = LoadState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _posts = await apiService.getPosts();
      _loadState = LoadState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _loadState = LoadState.error;
    }
    notifyListeners();
  }
}