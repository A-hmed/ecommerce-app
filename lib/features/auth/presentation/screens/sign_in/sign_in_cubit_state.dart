import 'package:ecommerce_app/features/base/base_api_state.dart';

class SignInCubitState {
  late BaseApiState loginState;

  SignInCubitState({required this.loginState});

  SignInCubitState.initial() {
    loginState = BaseIdleState();
  }
}
