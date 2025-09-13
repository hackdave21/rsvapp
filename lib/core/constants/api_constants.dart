/// Constantes essentielles pour la configuration de l'API
class ApiConstants {
  ApiConstants._();

  // URL de base de l'API 
  static const String baseUrl = 'https://votre-api.com/api';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Endpoints principaux
  // static const String login = '/auth/login';
  // static const String register = '/auth/register';
  // static const String logout = '/auth/logout';
  // static const String refreshToken = '/auth/refresh';
  // static const String userProfile = '/auth/user';

  // static const String properties = '/properties';
  // static const String propertiesFeatured = '/properties/featured';
  // static const String propertiesSearch = '/properties/search';

  // static const String categories = '/categories';
  // static const String favorites = '/favorites';

  // Headers
  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String applicationJson = 'application/json';

  // Codes de réponse HTTP
  static const int success = 200;
  static const int created = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int validationError = 422;
  static const int serverError = 500;

  // Clés pour les réponses API
  static const String dataKey = 'data';
  static const String messageKey = 'message';
  static const String errorsKey = 'errors';

  /// Construit l'URL complète pour un endpoint
  static String buildUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}