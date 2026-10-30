import 'package:get/get.dart';
import 'package:praktikum_papb/middleware/auth_middleware.dart';
import 'package:praktikum_papb/middleware/guest_middleware.dart';
import 'package:praktikum_papb/pages/post_detail_page.dart';
import 'package:praktikum_papb/pages/post_list_page.dart';
import 'package:praktikum_papb/pages/favorite_page.dart';
import 'package:praktikum_papb/pages/profile_page.dart';
import 'package:praktikum_papb/pages/register_page.dart';
import 'package:praktikum_papb/pages/login_page.dart';
import 'package:praktikum_papb/controller/register_controller.dart';
import 'package:praktikum_papb/controller/login_controller.dart';
import 'package:praktikum_papb/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.home;

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const PostListPage(),
      transition: Transition.noTransition,
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.favorite,
      page: () => const FavoritePage(),
      transition: Transition.noTransition,
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      transition: Transition.noTransition,
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.postDetail,
      page: () => PostDetailPage(postId: int.tryParse(Get.parameters['id'] ?? '')),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() => Get.lazyPut(() => RegisterController())),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
      middlewares: [GuestMiddleware()],
    ),
  ];
}