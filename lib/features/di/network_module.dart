import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/utils/dio_utils.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio getDio() => DioUtils.getInstance();
}
