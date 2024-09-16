import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/base/data/utils/shared_pref_utls.dart';

///https://ecommerce.routemisr.com
class DioUtils {
  static Dio init() {
    Dio dio = Dio();
    dio.options.baseUrl = "https://ecommerce.routemisr.com";
    dio.interceptors.add(LoggingInterceptors());
    dio.interceptors.add(AuthInterceptors(SharedPrefUtils()));
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

class AuthInterceptors extends Interceptor {
  SharedPrefUtils sharedPrefUtils;

  AuthInterceptors(this.sharedPrefUtils);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = {"token": await sharedPrefUtils.getToken()};
    super.onRequest(options, handler);
  }
}
