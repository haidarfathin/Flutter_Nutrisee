import 'package:dio/dio.dart';

class DioExceptionWrapper extends DioException {
  final DioException dioException;

  DioExceptionWrapper(
      {required super.requestOptions, required this.dioException});

  @override
  String get message {
    if (dioException.type == DioExceptionType.badResponse) {
      final body = dioException.response?.data as Map<String, dynamic>;
      return body['message'].toString();
    }
    return 'unknown error';
  }
}
