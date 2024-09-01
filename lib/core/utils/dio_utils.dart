import 'package:dio/dio.dart';

class DioUtils {
  Dio getInstance() {
    final options = BaseOptions(
      baseUrl: 'https://ecommerce.routemisr.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    return Dio(options);
  }
}
