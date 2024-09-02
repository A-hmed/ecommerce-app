import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/sign_in/sign_in_cubit_state.dart';
import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInCubit extends Cubit<SignInCubitState> {
  AuthRepository authRepository;

  SignInCubit(this.authRepository) : super(SignInCubitState.initial());

  void login(String email, String password) async {
    emit(SignInCubitState(loginState: BaseLoadingState()));
    Either<Failure, void> response =
        await authRepository.login(email, password);
    if (response.isLeft) {
      emit(SignInCubitState(loginState: BaseErrorState(response.left)));
    } else {
      emit(SignInCubitState(loginState: BaseSuccessState(null)));
    }
  }
}
