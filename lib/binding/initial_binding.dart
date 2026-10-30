import 'package:get/get.dart';
import 'package:praktikum_papb/service/api_service.dart';
import 'package:praktikum_papb/controller/post_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Add your initial dependencies here
    Get.lazyPut(() => ApiService(), fenix: true);
    Get.lazyPut(() => PostController(apiService: Get.find()), fenix: true);
  }
}