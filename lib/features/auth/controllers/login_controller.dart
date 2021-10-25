import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../repositories/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = Get.find();

  final usernameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final loading = false.obs;

  login() async {
    loading.value = true;

    final result = await _authRepository.login(
      usernameController.value.text,
      passwordController.value.text,
    );

    result.fold(
      (failure) {
        Get.snackbar('Oopss...', failure.message);
      },
      (_) => null,
    );
  }
}
