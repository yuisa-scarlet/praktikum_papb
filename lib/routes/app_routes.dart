abstract class AppRoutes {
  static const home = '/home';
  static const postDetail = '/posts/:id';
  static const favorite = '/favorites';
  static const profile = '/profile';

  static const login = '/login';
  static const register = '/register';

  // halaman a
  // halaman b

  static String postDetailPath(int id) => '/posts/$id';
}