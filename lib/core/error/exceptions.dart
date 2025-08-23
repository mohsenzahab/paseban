/// Custom exceptions to distinguish different special errors.
sealed class CException implements Exception {
  final String? message;
  final int? errCode;

  CException({this.errCode, this.message});

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}

/// Network related errors such connection and etc.
class NetworkException extends CException {
  NetworkException({super.errCode, super.message});
}

/// Server related errors such an invalid ID.
class ServerException extends NetworkException {
  ServerException({super.errCode, super.message});
}

/// System related errors.
class LocalException extends CException {
  LocalException({super.errCode, super.message});
}

/// Storage related errors.
class CacheException extends LocalException {
  CacheException({super.errCode, super.message});
}
