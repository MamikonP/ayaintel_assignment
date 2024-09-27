class ApiException implements Exception {
  ApiException({this.message = ''});

  final String message;

  @override
  String toString() {
    return message;
  }
}

class InternalServerException extends ApiException {
  InternalServerException()
      : super(message: 'Error while communicating to the server');
}

class BadGateWayException extends ApiException {
  BadGateWayException() : super(message: 'Request failed due to server-side');
}

class BadRequestException extends ApiException {
  BadRequestException({String? message})
      : super(message: message ?? 'Invalid Request');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super(message: 'Incorrect credentials');
}

class ConflictException extends ApiException {
  ConflictException() : super(message: 'Conflict error');
}

class ForbiddenException extends ApiException {
  ForbiddenException() : super(message: 'No Access to perform the request');
}

class NotFoundException extends ApiException {
  NotFoundException([String? message])
      : super(message: message ?? 'Resource was not found or does not exist');
}

class InvalidException extends ApiException {
  InvalidException({required int statusCode, String message = ''})
      : super(
            message: 'Response failed with status code $statusCode: $message');
}

class BackendException implements Exception {
  BackendException(this.message);
  final dynamic message;
}

class ResponseEmptyException extends ApiException {
  ResponseEmptyException() : super(message: 'Response is null');
}

class ValidationException extends ApiException {
  ValidationException({String? message})
      : super(message: message ?? 'Validation error');
}
