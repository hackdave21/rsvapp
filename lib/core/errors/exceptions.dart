
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, [this.code]);
  
  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// exception pour les erreurs de serveur coté backend
class ServerException extends AppException {
  const ServerException([String message = 'Erreur serveur']) : super(message, 'SERVER_ERROR');
}

/// exception pour les erreurs client pour les requetes
class ClientException extends AppException {
  final int? statusCode;
  
  const ClientException(String message, [this.statusCode]) : super(message, 'CLIENT_ERROR');
  
  @override
  String toString() => 'ClientException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Exception pour les erreurs de stockage local
class CacheException extends AppException {
  const CacheException([String message = 'Erreur de cache']) : super(message, 'CACHE_ERROR');
}

/// exception pour les erreurs de réseau
class NetworkException extends AppException {
  const NetworkException([String message = 'Erreur réseau']) : super(message, 'NETWORK_ERROR');
}

/// exception pour les erreurs d'authentification
class AuthException extends AppException {
  const AuthException([String message = "Erreur d'authentification"]) : super(message, 'AUTH_ERROR');
}

/// exception pour les erreurs de validation
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;
  
  const ValidationException(String message, [this.errors]) : super(message, 'VALIDATION_ERROR');
  
  @override
  String toString() {
    String baseString = super.toString();
    if (errors != null && errors!.isNotEmpty) {
      String errorDetails = errors!.entries
          .map((e) => '${e.key}: ${e.value.join(', ')}')
          .join('; ');
      return '$baseString - Details: $errorDetails';
    }
    return baseString;
  }
}

/// exception pour les erreurs de timeout
class TimeoutException extends AppException {
  const TimeoutException([String message = 'Timeout de la requête']) : super(message, 'TIMEOUT_ERROR');
}

/// exception pour les erreurs de parsing/format
class FormatException extends AppException {
  const FormatException([String message = 'Erreur de format des données']) : super(message, 'FORMAT_ERROR');
}

/// exception pour les erreurs de permissions
class PermissionException extends AppException {
  const PermissionException([String message = 'Permission refusée']) : super(message, 'PERMISSION_ERROR');
}

/// exception générique pour les erreurs inattendues
class UnexpectedException extends AppException {
  const UnexpectedException([String message = 'Erreur inattendue']) : super(message, 'UNEXPECTED_ERROR');
}