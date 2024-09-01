import 'package:either_dart/either.dart';

import '../../../../core/utils/app_error.dart';

abstract class OnlineDataSource {
  Future<Either<Failure, void>> login(String email, String password);

  Future<Either<Failure, void>> register();
}

class OnlineDataSourceImpl2 implements OnlineDataSource {
  @override
  Future<Either<Failure, void>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  test() {
    // TODO: implement test
    throw UnimplementedError();
  }
}
