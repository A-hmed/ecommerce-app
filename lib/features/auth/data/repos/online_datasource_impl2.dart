import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/auth/data/repos/online_datasource.dart';
import 'package:either_dart/either.dart';

class OnlineDataSourceImpl extends OnlineDataSource {
  OnlineDataSourceImpl();

  @override
  Future<Either<Failure, void>> login(String email, String password) async {}

  @override
  Future<Either<Failure, void>> register() {
    throw "";
  }
}
