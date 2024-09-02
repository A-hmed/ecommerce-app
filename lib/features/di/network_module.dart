import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/utils/dio_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio getDio() => DioUtils.getInstance();

  @singleton
  InternetConnectionChecker getChecker() => InternetConnectionChecker();
}
