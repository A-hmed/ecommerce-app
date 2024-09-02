import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/features/auth/data/repos/online_datasource.dart';
import 'package:ecommerce_app/features/auth/domain/repo/auth_repo.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/utils/app_error.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  OnlineDataSource onlineDataSource;

  AuthRepoImpl(this.onlineDataSource);

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      return onlineDataSource.login(email, password);
    } else {
      return Left(ConnectionFailure(AppConstants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> register() {
    throw "";
  }
}
