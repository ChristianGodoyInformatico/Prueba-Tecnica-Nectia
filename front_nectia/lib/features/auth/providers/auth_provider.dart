import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_nectia/core/providers/dio_provider.dart';
import 'package:front_nectia/features/auth/controllers/auth_controller.dart';
import '../models/user_model.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState({this.user, this.isLoading = false, this.errorMessage});

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class AuthProvider extends StateNotifier<AuthState> {
  final AuthController _authController;

  AuthProvider(this._authController) : super(AuthState());

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final user = await _authController.login(username, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void logout() {
    state = AuthState();
  }
}

final authControllerProvider = Provider<AuthController>((ref) {
  final dio = ref.read(dioProvider);
  return AuthController(dio);
});

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final authController = ref.watch(authControllerProvider);
  return AuthProvider(authController);
});
