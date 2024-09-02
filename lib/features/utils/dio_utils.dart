import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DioUtils {
  static Dio getInstance() {
    final options = BaseOptions(
      baseUrl: 'https://ecommerce.routemisr.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    Dio dio = Dio(options);
    dio.interceptors.add(LoggingInterceptors());
    return dio;
  }
}

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}, BODY => ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}, ${err.response?.data}');
    super.onError(err, handler);
  }
}
