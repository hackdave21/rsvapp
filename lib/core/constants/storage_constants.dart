/// Constantes pour le stockage local (SharedPreferences)
class StorageConstants {
  StorageConstants._(); // Constructeur privé pour éviter l'instanciation

  // Authentification
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiry = 'token_expiry';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';

  // Préférences utilisateur
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';

  // Données de l'application
  static const String favorites = 'favorites';
  static const String searchHistory = 'search_history';
  static const String notificationsEnabled = 'notifications_enabled';

  // Cache
  static const String categoriesCache = 'categories_cache';

  // Configuration
  static const String apiBaseUrl = 'api_base_url';
  static const String appVersion = 'app_version';
  static const String buildNumber = 'build_number';
}