class AppStrings {
  /// API Request Related Strings

  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';
  static const String authorizationHeader = 'Authorization';
  static const String applicationJson = 'application/json';
  static const String bearerPrefix = 'Bearer ';
  static const String noConnectionToInternetError = 'No internet connection';
  static const String requestTimeoutError = 'Request timed out';
  static const String failedTokenRefreshError = 'Failed to refresh token';
  static const String tokenRefreshFailed = 'Token refresh failed ';
  static const String noServerResponse = 'No response from server';
  static const String unknownError = 'Unknown error';
  static const String unauthorizedError = 'Unauthorized';
  static const String errorOccurred = "Une erreur est survenue";

  static String requestFailed(String error) => 'Request failed: $error';

  static String serverError(int statusCode, String error) =>
      'Server error $statusCode: $error';

  static String badRequest(String error) => 'Bad request: $error';

  static String appException(String error) => 'AppException: $error';
}
