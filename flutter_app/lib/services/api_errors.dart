class ApiException implements Exception {
  ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  NetworkException(super.message);
}

class ParsingException extends ApiException {
  ParsingException(super.message);
}

class ServerException extends ApiException {
  ServerException(super.message);
}
