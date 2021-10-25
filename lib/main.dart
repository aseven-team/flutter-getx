import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'features/auth/controllers/auth_controller.dart';
import 'features/auth/pages/login_page.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'features/home/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialize();
  runApp(App());
}

void initialize() {
  Get.lazyPut(() => const FlutterSecureStorage());
  Get.lazyPut(() => AuthRepository());
  Get.lazyPut(() => AuthController());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      home: Obx(() {
        if (_authController.isAuthenticated) {
          return HomePage();
        }

        if (_authController.isUnauthenticated) {
          return LoginPage();
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
