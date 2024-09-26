import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthController {
  final Dio _dio;
  AuthController(this._dio);

  Future<UserModel> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Error al iniciar sesión');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}
