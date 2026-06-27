/// Custom exceptions and error handling
abstract class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

class SmsPermissionException extends AppException {
  SmsPermissionException(String message) : super(message);
}

class DatabaseException extends AppException {
  DatabaseException(String message) : super(message);
}

class SmsReadingException extends AppException {
  SmsReadingException(String message) : super(message);
}

class ParsingException extends AppException {
  ParsingException(String message) : super(message);
}

class RepositoryException extends AppException {
  RepositoryException(String message) : super(message);
}

class CacheException extends AppException {
  CacheException(String message) : super(message);
}
