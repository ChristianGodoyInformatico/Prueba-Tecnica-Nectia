import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class AuthInterceptor extends Interceptor {
  final ProviderRef ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Rutas que no requieren autenticación
    const unauthenticatedPaths = ['/auth/login'];

    // Verificar si la ruta actual está en la lista de rutas sin autenticación
    final requiresAuth = !unauthenticatedPaths.contains(options.path);

    if (requiresAuth) {
      final authState = ref.read(authProvider);
      final token = authState.user?.token;

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        // Opcional: Manejar el caso en que no hay token disponible
        // Por ejemplo, lanzar una excepción o redirigir al login
      }
    }

    super.onRequest(options, handler);
  }
}
