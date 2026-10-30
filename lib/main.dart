import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/binding/initial_binding.dart';
import 'package:praktikum_papb/database/app_database.dart';
import 'package:praktikum_papb/routes/app_pages.dart';
import 'package:praktikum_papb/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();

  await Get.putAsync(
    () async => await AuthService(
      database: AppDatabase(),
      prefs: prefs
    ).init(),
    permanent: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter API List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialBinding: InitialBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
