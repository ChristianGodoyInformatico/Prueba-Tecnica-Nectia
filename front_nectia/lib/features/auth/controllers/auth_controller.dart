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

      print('que llega en la data: ${response.data}');
      print("status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        print('aqui esta el error');
        throw Exception('Error al iniciar sesión');
      }
    } catch (e) {
      print('aqui esta el error2');
      throw Exception('Error de red: $e');
    }
  }
}
