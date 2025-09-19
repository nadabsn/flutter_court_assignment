import '../utils/app_strings.dart';

class AppException implements Exception {
  final String message;

  AppException(this.message);
}

class NoConnectionException extends AppException {
  NoConnectionException() : super(AppStrings.noConnectionToInternetError);
}

class TimeoutException extends AppException {
  TimeoutException() : super(AppStrings.requestTimeoutError);
}

class UnauthorizedException extends AppException {
  UnauthorizedException() : super(AppStrings.unauthorizedError);
}

class BadRequestException extends AppException {
  BadRequestException(String message) : super(AppStrings.badRequest(message));
}

class ServerException extends AppException {
  final int statusCode;

  ServerException(this.statusCode, String message)
      : super(AppStrings.serverError(statusCode, message));
}
