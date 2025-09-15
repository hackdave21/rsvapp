import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rvsapp/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final String code;
  
  const Failure(this.message, this.code);
  
  @override
  List<Object?> get props => [message, code];
  
  @override
  String toString() => 'Failure: $message (Code: $code)';
}

/// échec générique
class GenericFailure extends Failure {
  const GenericFailure([String message = 'Une erreur est survenue']) 
      : super(message, 'GENERIC_ERROR');
}

/// échec de serveur (erreurs 500)
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Erreur du serveur. Veuillez réessayer plus tard.']) 
      : super(message, 'SERVER_ERROR');
  
  factory ServerFailure.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Timeout de la connexion');
      case DioExceptionType.badCertificate:
        return const ServerFailure('Certificat invalide');
      case DioExceptionType.badResponse:
        return ServerFailure(_handleResponseError(e.response));
      case DioExceptionType.cancel:
        return const ServerFailure('Requête annulée');
      case DioExceptionType.connectionError:
        return const ServerFailure('Erreur de connexion');
      case DioExceptionType.unknown:
        return const ServerFailure('Erreur inconnue');
    }
  }
  
  static String _handleResponseError(Response? response) {
    if (response == null) return 'Réponse serveur invalide';
    
    switch (response.statusCode) {
      case 400:
        return 'Requête invalide';
      case 401:
        return 'Non autorisé';
      case 403:
        return 'Accès refusé';
      case 404:
        return 'Ressource non trouvée';
      case 500:
        return 'Erreur interne du serveur';
      case 502:
        return 'Mauvais gateway';
      case 503:
        return 'Service indisponible';
      default:
        return 'Erreur serveur (${response.statusCode})';
    }
  }
}

/// echec client ( pour erreurs 400)
class ClientFailure extends Failure {
  final int? statusCode;
  
  const ClientFailure(String message, [this.statusCode]) : super(message, 'CLIENT_ERROR');
  
  @override
  List<Object?> get props => [message, code, statusCode];
}

/// échec de réseau
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Vérifiez votre connexion internet']) 
      : super(message, 'NETWORK_ERROR');
}

/// échec de cache
class CacheFailure extends Failure {
  const CacheFailure([String message = "Erreur lors de l'accès aux données locales"]) 
      : super(message, 'CACHE_ERROR');
}

/// echec d'authentification
class AuthFailure extends Failure {
  const AuthFailure([String message = "Erreur d'authentification"]) 
      : super(message, 'AUTH_ERROR');
}

/// echec de validation
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;
  
  const ValidationFailure(String message, [this.fieldErrors]) 
      : super(message, 'VALIDATION_ERROR');
  
  @override
  List<Object?> get props => [message, code, fieldErrors];
  
  /// obtenenir les erreurs pour un champ spécifique
  List<String> getFieldErrors(String field) {
    return fieldErrors?[field] ?? [];
  }
  
  /// verifier si un champ a des erreurs
  bool hasFieldError(String field) {
    return fieldErrors?.containsKey(field) ?? false;
  }
  
  /// obtenir la première erreur d'un champ
  String? getFirstFieldError(String field) {
    final errors = getFieldErrors(field);
    return errors.isNotEmpty ? errors.first : null;
  }
}

/// echec de timeout
class TimeoutFailure extends Failure {
  const TimeoutFailure([String message = 'La requête a pris trop de temps']) 
      : super(message, 'TIMEOUT_ERROR');
}

/// echec de format
class FormatFailure extends Failure {
  const FormatFailure([String message = 'Format de données invalide']) 
      : super(message, 'FORMAT_ERROR');
}

/// echec de permission
class PermissionFailure extends Failure {
  const PermissionFailure([String message = 'Permission refusée']) 
      : super(message, 'PERMISSION_ERROR');
}

/// echec pour les ressources non trouvées
class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Ressource non trouvée']) 
      : super(message, 'NOT_FOUND_ERROR');
}

/// echec pour les conflits (409)
class ConflictFailure extends Failure {
  const ConflictFailure([String message = 'Conflit de données']) 
      : super(message, 'CONFLICT_ERROR');
}

/// extension pour mapper les exceptions vers les failures
extension ExceptionToFailure on Exception {
  Failure toFailure() {
    if (this is ServerException) {
      return ServerFailure((this as ServerException).message);
    } else if (this is ClientException) {
      final clientException = this as ClientException;
      return ClientFailure(clientException.message, clientException.statusCode);
    } else if (this is NetworkException) {
      return NetworkFailure((this as NetworkException).message);
    } else if (this is CacheException) {
      return CacheFailure((this as CacheException).message);
    } else if (this is AuthException) {
      return AuthFailure((this as AuthException).message);
    } else if (this is ValidationException) {
      final validationException = this as ValidationException;
      return ValidationFailure(validationException.message, validationException.errors);
    } else if (this is TimeoutException) {
      return TimeoutFailure((this as TimeoutException).message);
    } else if (this is FormatException) {
      return FormatFailure((this as FormatException).message);
    } else if (this is PermissionException) {
      return PermissionFailure((this as PermissionException).message);
    } else {
      return GenericFailure(toString());
    }
  }
}