import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/data/model/response/auth_response.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth/data_sources/remote_auth_data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  static const signInUrl = "/api/v1/auth/signin";
  Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      Response serverResponse = await dio.post(signInUrl,
          data: LoginRequest(email: email, password: password).toJson());
      AuthResponse myResponse = AuthResponse.fromJson(serverResponse.data);
      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! <= 300) {
        return const Right(null);
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      print(e);
      return Left(ApiFailure());
    }
  }

  @override
  Future<Either<Failure, void>> register() {
    // TODO: implement register
    throw UnimplementedError();
  }
}
