import 'package:get/get.dart';
import 'package:praktikum_papb/enum/load_state.dart';
import 'package:praktikum_papb/model/post.dart';
import 'package:praktikum_papb/service/api_service.dart';

class PostController extends GetxController {
  final ApiService apiService;
  PostController({required this.apiService});

  final posts = <Post>[].obs;
  final loadState = LoadState.initial.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  Post? findById(int id) => posts.firstWhereOrNull((post) => post.id == id);

  Future<void> loadPosts() async {
    loadState.value = LoadState.loading;
    errorMessage.value = '';

    try {
      posts.value = await apiService.getPosts();
      loadState.value = LoadState.loaded;
    } catch (e) {
      errorMessage.value = e.toString();
      loadState.value = LoadState.error;
    }
  }
}