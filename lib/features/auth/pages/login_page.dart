import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller.usernameController.value,
              decoration: const InputDecoration(
                icon: Icon(Icons.person_outline),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _controller.passwordController.value,
              decoration: const InputDecoration(
                icon: Icon(Icons.person_outline),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 36),
            ElevatedButton(
              onPressed: () => _controller.login(),
              child: Obx(
                () => _controller.loading.value
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
