import 'package:ecommerce_app/features/base/failures/failures.dart';

abstract class BaseApiState {}

class BaseLoadingState extends BaseApiState {}

class BaseIdleState extends BaseApiState {}

class BaseSuccessState<T> extends BaseApiState {
  T data;

  BaseSuccessState(this.data);
}

class BaseErrorState extends BaseApiState {
  Failure failure;

  BaseErrorState(this.failure);

  @override
  String toString() {
    return failure.errorMessage;
  }
}
