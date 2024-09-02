import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/auth/data/models/AuthResponse.dart';
import 'package:ecommerce_app/features/auth/data/repos/online_datasource.dart';
import 'package:ecommerce_app/features/utils/shared_pref_utils.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl extends OnlineDataSource {
  Dio dio;
  SharedPrefUtils sharedPrefUtils;

  OnlineDataSourceImpl(this.dio, this.sharedPrefUtils);

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      Response response = await dio.post("/api/v1/auth/signin", data: {
        "email": email,
        "password": password,
        },
      );
      AuthResponse body = AuthResponse.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        sharedPrefUtils.saveUser(body.user!);
        sharedPrefUtils.saveToken(body.token!);
        return const Right(null);
      } else {
        return Left(Failure(body.message ?? AppConstants.defaultErrorMessage));
      }
    } catch (e) {
      return Left(Failure(AppConstants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> register() {
    throw "";
  }
}
