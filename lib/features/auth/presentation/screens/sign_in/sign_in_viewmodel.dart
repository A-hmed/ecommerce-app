import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInViewModel extends Cubit<SignInViewModelState> {
  LoginUseCase loginUseCase;

  SignInViewModel(this.loginUseCase) : super(SignInViewModelState.initial());

  login(String email, String password) async {
    emit(SignInViewModelState(BaseLoadingState()));
    Either<Failure, void> response =
        await loginUseCase.execute(email, password);
    response.fold((failure) {
      emit(SignInViewModelState(BaseErrorState(failure.errorMessage)));
    }, (_) {
      emit(SignInViewModelState(BaseSuccessState(null)));
    });
  }
}

class SignInViewModelState {
  late BaseApiState loginState;

  SignInViewModelState(this.loginState);

  SignInViewModelState.initial() {
    loginState = BaseIdleState();
  }
}
