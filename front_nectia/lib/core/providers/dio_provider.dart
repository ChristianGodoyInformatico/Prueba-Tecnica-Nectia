import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_nectia/features/auth/interceptors/auth_interceptor.dart';


final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      // baseUrl: 'http://10.0.2.2:3000/api',
      baseUrl:'http://18.191.43.23:3000/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  // Agregamos el AuthInterceptor
  dio.interceptors.add(AuthInterceptor(ref));

  // // Agregamos el LogInterceptor para depuración
  // dio.interceptors.add(LogInterceptor(
  //   requestHeader: true,
  //   requestBody: true,
  //   responseHeader: true,
  //   responseBody: true,
  //   error: true,
  //   // compact: true,
  // ));

  return dio;
});



