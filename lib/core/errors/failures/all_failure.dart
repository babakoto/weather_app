import 'package:weather_app/core/utils/failure_or_success/failure.dart';

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message,
    super.code,
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message,
    super.code,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.message,
    super.code,
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message,
  });
}

class StorageFailure extends Failure {}
