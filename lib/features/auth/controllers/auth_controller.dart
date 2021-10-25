import 'dart:async';

import 'package:get/get.dart';

import '../models/user.dart';
import '../repositories/auth_repository.dart';

class AuthController extends GetxController {
  AuthController() {
    _authStateSubscription = _authRepository.status.listen(
      (status) => _onAuthStatusChanged(status),
    );
  }

  final AuthRepository _authRepository = Get.find();
  late StreamSubscription<AuthState> _authStateSubscription;

  final _state = AuthState.unauthenticated.obs;
  final _user = Rxn<User>();

  AuthState get state => _state.value;
  User? get user => _user.value;

  bool get isAuthenticated => state == AuthState.authenticated;
  bool get isUnauthenticated => state == AuthState.unauthenticated;

  @override
  void onInit() {
    getAuthenticatedUser();

    super.onInit();
  }

  void _onAuthStatusChanged(AuthState status) {
    if (status == AuthState.authenticated) {
      getAuthenticatedUser();
    } else {
      _state.value = status;
    }
  }

  getAuthenticatedUser() async {
    _state.value = AuthState.loading;

    final result = await _authRepository.getAuthenticatedUser();

    result.fold(
      (failure) {
        _state.value = AuthState.unauthenticated;
      },
      (user) {
        _user.value = user;
        _state.value = AuthState.authenticated;
      },
    );
  }

  @override
  void onClose() {
    _authStateSubscription.cancel();
    _authRepository.dispose();

    super.onClose();
  }
}
