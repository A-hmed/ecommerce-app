class Failure {
  String errorMessage;

  Failure(this.errorMessage);
}

class ConnectionFailure extends Failure {
  ConnectionFailure([String? errorMessage])
      : super(errorMessage ??
            "Please check your internet"
                " connection and try again later");
}

class ApiFailure extends Failure {
  ApiFailure([String? errorMessage])
      : super(errorMessage ??
            "Something went wrong"
                " please try again later");
}

class UnAuthenticatedFailure extends Failure {
  UnAuthenticatedFailure([String? errorMessage])
      : super(errorMessage ?? "Session expired please log in again");
}
