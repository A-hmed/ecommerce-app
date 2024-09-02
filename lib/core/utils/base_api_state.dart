import 'package:ecommerce_app/core/utils/app_error.dart';

abstract class BaseApiState {}

class BaseIdleState extends BaseApiState {}

class BaseLoadingState extends BaseApiState {}

class BaseSuccessState<T> extends BaseApiState {
  T data;

  BaseSuccessState(this.data);
}

class BaseErrorState extends BaseApiState {
  Failure failure;

  BaseErrorState(this.failure);
}
