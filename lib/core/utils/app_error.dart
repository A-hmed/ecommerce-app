import 'package:ecommerce_app/core/resources/constants_manager.dart';

class Failure {
  String errorMessage;

  Failure(this.errorMessage);
}

class ConnectionFailure extends Failure {
  ConnectionFailure([super.errorMessage = AppConstants.internetErrorMessage]);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
}

class ApiFailure extends Failure {
  ApiFailure([super.errorMessage = AppConstants.defaultErrorMessage]);
}
