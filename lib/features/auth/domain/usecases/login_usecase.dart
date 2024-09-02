import 'package:ecommerce_app/features/auth/domain/repo/auth_repo.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/app_error.dart';

@injectable
class LoginUseCase {
  AuthRepo repo;

  LoginUseCase(this.repo);

  Future<Either<Failure, void>> execute(String email, String password) {
    return repo.login(email, password);
  }
}
