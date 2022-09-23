class UnauthorizedException implements Exception {
  final String message;
  final int code;

  const UnauthorizedException({
    this.message = "The username and/or password you entered is incorrect.",
    this.code = 400,
  });
}

class NetworkException implements Exception {
  final String message;
  final int code;

  const NetworkException({
    this.message = "No internet",
    this.code = 0,
  });
}

class ServerException implements Exception {
  final String message;
  final int code;

  const ServerException({
    this.message = "Server failure message",
    this.code = 500,
  });
}

class UnknownException implements Exception {
  final String message;

  const UnknownException({
    required this.message,
  });
}

class StorageException implements Exception {}
