import 'package:get/get.dart';
import 'package:praktikum_papb/pages/post_detail_page.dart';
import 'package:praktikum_papb/pages/post_list_page.dart';
import 'package:praktikum_papb/pages/favorite_page.dart';
import 'package:praktikum_papb/pages/profile_page.dart';
import 'package:praktikum_papb/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.home;

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const PostListPage(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: AppRoutes.favorite,
      page: () => const FavoritePage(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: AppRoutes.postDetail,
      page: () => PostDetailPage(postId: int.tryParse(Get.parameters['id'] ?? '')),    
    ),
  ];
}