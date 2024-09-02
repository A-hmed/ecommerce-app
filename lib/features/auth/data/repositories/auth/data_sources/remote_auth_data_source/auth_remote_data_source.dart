import 'package:either_dart/either.dart';

import '../../../../../../base/failures/failures.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, void>> login(String email, String password);

  Future<Either<Failure, void>> register();
}
