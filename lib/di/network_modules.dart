import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/refresh_token_interceptor.dart';
import 'injection.dart';

import '../core/config/config.dart';

@module
abstract class NetworkModule {
  @dev
  Dio get client {
    final dio = Dio(
      BaseOptions(
        baseUrl: Config.baseUrl,
        sendTimeout: Config.timeout,
        connectTimeout: Config.timeout,
        receiveTimeout: Config.timeout,
      ),
    );
    // dio.interceptors
    //     .add(DioLoggingInterceptor(level: Level.body, compact: false));
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      requestHeader: false,
      responseHeader: false,
      error: true,
    ));
    dio.interceptors.add(getIt<RefreshTokenInterceptor>());
    return dio;
  }
}
