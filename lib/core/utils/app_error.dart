class Failure {
  String errorMessage;

  Failure(this.errorMessage);
}

class ConnectionFailure extends Failure {
  ConnectionFailure(super.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
}

class ApiFailure extends Failure {
  ApiFailure(super.errorMessage);
}
