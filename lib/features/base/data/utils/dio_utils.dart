import 'package:dio/dio.dart';

///https://ecommerce.routemisr.com
class DioUtils {
  static Dio init() {
    Dio dio = Dio();
    dio.options.baseUrl = "https://ecommerce.routemisr.com";
    dio.interceptors.add(LoggingInterceptors());
    return dio;
  }
}

extension ResponseExtension on Response {
  bool get isSuccessful => statusCode! >= 200 && statusCode! < 300;
}

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => BODY: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
