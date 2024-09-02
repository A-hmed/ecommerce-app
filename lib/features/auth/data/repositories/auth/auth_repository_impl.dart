import 'package:ecommerce_app/features/auth/data/repositories/auth/data_sources/remote_auth_data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  InternetConnectionChecker internetConnectionChecker;

  AuthRepositoryImpl(this.authRemoteDataSource, this.internetConnectionChecker);

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    if ((await internetConnectionChecker.hasConnection)) {
      return authRemoteDataSource.login(email, password);
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> register() {
    // TODO: implement register
    throw UnimplementedError();
  }
}
