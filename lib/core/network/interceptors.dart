import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rvsapp/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_constants.dart';

typedef OnUnauthorizedCallback = void Function();

/// Intercepteur pour l'authentification
/// Ajoute automatiquement le token Bearer aux requêtes
class AuthInterceptor extends Interceptor {
  final SharedPreferences sharedPreferences;
  final OnUnauthorizedCallback? onUnauthorized;
  bool _isHandlingUnauthorized = false;
  
  AuthInterceptor({
    required this.sharedPreferences,
    this.onUnauthorized,
  });
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isHandlingUnauthorized) {
      _isHandlingUnauthorized = true;
      
      await sharedPreferences.remove(StorageConstants.authToken);
      
      if (onUnauthorized != null) {
        onUnauthorized!();
      }
      
      _isHandlingUnauthorized = false;
    }
    
    super.onError(err, handler);
  }
}

/// Intercepteur de logging pour le debugging
/// Affiche les détails des requêtes et réponses en mode debug
class LoggingInterceptor extends Interceptor {
  static const String _tag = 'HTTP';
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('[$_tag] REQUEST');
      print('[$_tag] Method: ${options.method}');
      print('[$_tag] URL: ${options.uri}');
      print('[$_tag] Headers: ${options.headers}');
      if (options.data != null) {
        print('[$_tag] Body: ${options.data}');
      }
      if (options.queryParameters.isNotEmpty) {
        print('[$_tag] Query Parameters: ${options.queryParameters}');
      }
      print('[$_tag] ================================');
    }
    super.onRequest(options, handler);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('[$_tag] RESPONSE');
      print('[$_tag] Status Code: ${response.statusCode}');
      print('[$_tag] URL: ${response.requestOptions.uri}');
      print('[$_tag] Headers: ${response.headers}');
      print('[$_tag] Data: ${response.data}');
      print('[$_tag] ================================');
    }
    super.onResponse(response, handler);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('[$_tag] ERROR');
      print('[$_tag] Type: ${err.type}');
      print('[$_tag] Message: ${err.message}');
      print('[$_tag] URL: ${err.requestOptions.uri}');
      if (err.response != null) {
        print('[$_tag] Status Code: ${err.response?.statusCode}');
        print('[$_tag] Response Data: ${err.response?.data}');
      }
      print('[$_tag] ================================');
    }
    super.onError(err, handler);
  }
}

/// Intercepteur pour la gestion des erreurs
/// Transforme les erreurs Dio en exceptions personnalisées
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Exception exception;
    
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = const TimeoutException('La requête a pris trop de temps');
        break;
        
      case DioExceptionType.connectionError:
        exception = const NetworkException('Erreur de connexion réseau');
        break;
        
      case DioExceptionType.badResponse:
        exception = _handleBadResponse(err.response);
        break;
        
      case DioExceptionType.cancel:
        exception = const NetworkException('Requête annulée');
        break;
        
      case DioExceptionType.unknown:
      default:
        if (err.message?.contains('SocketException') == true) {
          exception = const NetworkException('Pas de connexion internet');
        } else {
          exception = UnexpectedException(err.message ?? 'Erreur inconnue');
        }
        break;
    }
    
    // Remplace l'erreur Dio par notre exception personnalisée
    handler.reject(DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: exception,
    ));
  }
  
  /// Gère les erreurs de réponse (4xx, 5xx)
  Exception _handleBadResponse(Response? response) {
    if (response == null) {
      return const ServerException('Aucune réponse du serveur');
    }
    
    final statusCode = response.statusCode ?? 0;
    
    // Erreurs client (4xx)
    if (statusCode >= 400 && statusCode < 500) {
      switch (statusCode) {
        case 401:
          return const AuthException('Non autorisé');
        case 403:
          return const PermissionException('Accès interdit');
        case 404:
          return const ClientException('Ressource non trouvée', 404);
        case 422:
          return _handleValidationError(response);
        default:
          return ClientException(
            _extractErrorMessage(response) ?? 'Erreur client',
            statusCode,
          );
      }
    }
    
    // Erreurs serveur (5xx)
    if (statusCode >= 500) {
      return ServerException(
        _extractErrorMessage(response) ?? 'Erreur serveur',
      );
    }
    
    return ClientException('Erreur HTTP $statusCode', statusCode);
  }
  
  /// Gère les erreurs de validation (422)
  ValidationException _handleValidationError(Response response) {
    try {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        String message = data['message'] ?? 'Erreur de validation';
        Map<String, List<String>>? errors;
        
        // Format Laravel standard
        if (data['errors'] is Map<String, dynamic>) {
          errors = {};
          final errorData = data['errors'] as Map<String, dynamic>;
          errorData.forEach((key, value) {
            if (value is List) {
              errors![key] = value.cast<String>();
            } else if (value is String) {
              errors![key] = [value];
            }
          });
        }
        
        return ValidationException(message, errors);
      }
    } catch (e) {
      // Si on ne peut pas parser les erreurs, on retourne une erreur générique
    }
    
    return const ValidationException('Données invalides');
  }
  
  /// Extrait le message d'erreur de la réponse
  String? _extractErrorMessage(Response response) {
    try {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data['message'] as String?;
      } else if (data is String) {
        return data;
      }
    } catch (e) {
      // Ignore les erreurs de parsing
    }
    return null;
  }
}

/// Intercepteur pour les tentatives de retry
/// Retente automatiquement les requêtes en cas d'échec réseau
class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration retryDelay;
  
  RetryInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && err.requestOptions.extra['retry_count'] != null) {
      final retryCount = err.requestOptions.extra['retry_count'] as int? ?? 0;
      
      if (retryCount < maxRetries) {
        // Attendre avant de réessayer
        await Future.delayed(retryDelay * (retryCount + 1));
        
        // Incrémenter le compteur de retry
        err.requestOptions.extra['retry_count'] = retryCount + 1;
        
        try {
          // Nouvelle tentative
          final response = await Dio().fetch(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (e) {
          // Si la nouvelle tentative échoue, on continue avec l'erreur
        }
      }
    }
    
    super.onError(err, handler);
  }
  
  /// Détermine si une requête doit être retentée
  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError ||
           (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}

/// Intercepteur pour le cache simple
/// Cache les réponses GET pour améliorer les performances
class CacheInterceptor extends Interceptor {
  final Map<String, CacheItem> _cache = {};
  final Duration defaultCacheDuration;
  
  CacheInterceptor({this.defaultCacheDuration = const Duration(minutes: 5)});
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Ne cache que les requêtes GET
    if (options.method.toLowerCase() != 'get') {
      return super.onRequest(options, handler);
    }
    
    final key = _generateCacheKey(options);
    final cachedItem = _cache[key];
    
    // Vérifie si on a une réponse en cache valide
    if (cachedItem != null && !cachedItem.isExpired) {
      // Retourne la réponse depuis le cache
      handler.resolve(cachedItem.response);
      return;
    }
    
    super.onRequest(options, handler);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Cache la réponse si c'est une requête GET réussie
    if (response.requestOptions.method.toLowerCase() == 'get' && 
        response.statusCode == 200) {
      final key = _generateCacheKey(response.requestOptions);
      _cache[key] = CacheItem(
        response: response,
        expiry: DateTime.now().add(defaultCacheDuration),
      );
    }
    
    super.onResponse(response, handler);
  }
  
  /// Génère une clé de cache basée sur l'URL et les paramètres
  String _generateCacheKey(RequestOptions options) {
    return '${options.method}_${options.uri.toString()}';
  }
  
  /// Nettoie le cache des éléments expirés
  void clearExpiredCache() {
    _cache.removeWhere((key, value) => value.isExpired);
  }
  
  /// Vide complètement le cache
  void clearCache() {
    _cache.clear();
  }
}

/// Item de cache avec expiration
class CacheItem {
  final Response response;
  final DateTime expiry;
  
  CacheItem({required this.response, required this.expiry});
  
  bool get isExpired => DateTime.now().isAfter(expiry);
}