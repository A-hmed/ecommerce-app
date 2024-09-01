import 'package:either_dart/either.dart';

import '../../../../core/utils/app_error.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> login(String email, String password);

  Future<Either<Failure, void>> register();
}
