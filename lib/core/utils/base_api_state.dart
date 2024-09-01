abstract class BaseApiState {}

class BaseIdleState extends BaseApiState {}

class BaseLoadingState extends BaseApiState {}

class BaseSuccessState<T> extends BaseApiState {
  T data;

  BaseSuccessState(this.data);
}

class BaseErrorState extends BaseApiState {
  String errorMessage;

  BaseErrorState(this.errorMessage);
}
