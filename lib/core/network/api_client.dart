import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'interceptors.dart';
import 'network_info.dart';
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';

/// Client API principal utilisant Dio
/// Centralise toute la configuration réseau de l'application
class ApiClient {
  late final Dio _dio;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;
  
  ApiClient({
    required this.networkInfo,
    required this.sharedPreferences,
  }) {
    _dio = Dio();
    _configureDio();
  }
  
  /// Configuration du client Dio
  void _configureDio() {
    // Configuration de base
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    
    // Ajout des intercepteurs dans l'ordre
    _dio.interceptors.addAll([
      // 1. Logging (premier pour voir toutes les requêtes)
      LoggingInterceptor(),
      
      // 2. Auth (avant le cache pour inclure les headers)
      AuthInterceptor(sharedPreferences: sharedPreferences),
      
      // 3. Cache (avant retry pour éviter les requêtes inutiles)
      CacheInterceptor(defaultCacheDuration: Duration(minutes: 5)),
      
      // 4. Retry (avant error handling)
      RetryInterceptor(maxRetries: 3),
      
      // 5. Error handling (dernier pour capturer toutes les erreurs)
      ErrorInterceptor(),
    ]);
  }
  
  /// Getter pour accéder au Dio configuré
  Dio get dio => _dio;
  
  /// Vérifie la connectivité avant d'effectuer une requête
  Future<void> _checkConnectivity() async {
    if (!await networkInfo.hasInternetAccess) {
      throw const NetworkException('Aucune connexion internet disponible');
    }
  }
  
  /// GET Request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool checkConnectivity = true,
  }) async {
    if (checkConnectivity) await _checkConnectivity();
    
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  
  /// POST Request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool checkConnectivity = true,
  }) async {
    if (checkConnectivity) await _checkConnectivity();
    
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  
  /// PUT Request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool checkConnectivity = true,
  }) async {
    if (checkConnectivity) await _checkConnectivity();
    
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  
  /// PATCH Request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool checkConnectivity = true,
  }) async {
    if (checkConnectivity) await _checkConnectivity();
    
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  
  /// DELETE Request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool checkConnectivity = true,
  }) async {
    if (checkConnectivity) await _checkConnectivity();
    
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  
  /// Upload de fichier avec progression
  Future<Response<T>> uploadFile<T>(
    String path, {
    required String filePath,
    required String fieldName,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
    bool checkConnectivity = true,
  }) async {
    if (checkConnectivity) await _checkConnectivity();
    
    try {
      final formData = FormData();
      
      // Ajouter le fichier
      formData.files.add(MapEntry(
        fieldName,
        await MultipartFile.fromFile(filePath),
      ));
      
      // Ajouter les autres données
      if (data != null) {
        data.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }
      
      final response = await _dio.post<T>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  
  /// Download de fichier avec progression
  Future<Response> downloadFile(
    String path,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool checkConnectivity = true,
  }) async {
    if (checkConnectivity) await _checkConnectivity();
    
    try {
      final response = await _dio.download(
        path,
        savePath,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  
  /// Gestion centralisée des erreurs Dio
  Exception _handleDioError(DioException error) {
    // Si l'intercepteur d'erreur a déjà transformé l'erreur
    if (error.error is Exception) {
      return error.error as Exception;
    }
    
    // Fallback si l'intercepteur n'a pas traité l'erreur
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        if (statusCode >= 500) {
          return const ServerException();
        } else {
          return ClientException('Erreur client', statusCode);
        }
      case DioExceptionType.cancel:
        return const NetworkException('Requête annulée');
      case DioExceptionType.unknown:
      default:
        return UnexpectedException(error.message ?? 'Erreur inconnue');
    }
  }
  
  /// Met à jour le token d'authentification
  void updateAuthToken(String? token) {
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }
  
  /// Vide le cache des intercepteurs
  void clearCache() {
    for (var interceptor in _dio.interceptors) {
      if (interceptor is CacheInterceptor) {
        interceptor.clearCache();
        break;
      }
    }
  }
  
  /// Crée un CancelToken pour annuler les requêtes
  CancelToken createCancelToken() => CancelToken();
  
  /// Ferme le client et libère les ressources
  void close() {
    _dio.close();
  }
}

/// Extension pour des requêtes typées avec modèles
extension ApiClientTyped on ApiClient {
  /// GET avec mapping automatique vers un modèle
  Future<T> getModel<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    
    if (response.data == null) {
      throw const FormatException('Réponse vide du serveur');
    }
    
    try {
      return fromJson(response.data!);
    } catch (e) {
      throw FormatException('Erreur de parsing: $e');
    }
  }
  
  /// GET avec mapping vers une liste de modèles
  Future<List<T>> getModelList<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    String? dataKey, // Clé pour extraire la liste (ex: "data")
  }) async {
    final response = await get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    
    if (response.data == null) {
      throw const FormatException('Réponse vide du serveur');
    }
    
    try {
      List<dynamic> jsonList;
      
      if (dataKey != null) {
        // Extrait la liste depuis une clé spécifique
        jsonList = response.data![dataKey] as List<dynamic>;
      } else {
        // Assume que la réponse entière est une liste
        jsonList = response.data!['data'] as List<dynamic>? ?? 
                   response.data! as List<dynamic>;
      }
      
      return jsonList
          .cast<Map<String, dynamic>>()
          .map((json) => fromJson(json))
          .toList();
    } catch (e) {
      throw FormatException('Erreur de parsing de la liste: $e');
    }
  }
  
  /// POST avec mapping automatique de la réponse
  Future<T> postModel<T>(
    String path,
    dynamic data,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await post<Map<String, dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    
    if (response.data == null) {
      throw const FormatException('Réponse vide du serveur');
    }
    
    try {
      return fromJson(response.data!);
    } catch (e) {
      throw FormatException('Erreur de parsing: $e');
    }
  }
}

/// Factory pour créer et configurer ApiClient
class ApiClientFactory {
  static ApiClient? _instance;
  
  /// Crée ou retourne l'instance singleton d'ApiClient
  static Future<ApiClient> create({
    NetworkInfo? networkInfo,
    SharedPreferences? sharedPreferences,
  }) async {
    if (_instance != null) return _instance!;
    
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    final netInfo = networkInfo ?? NetworkInfoImpl(
      connectivity: Connectivity(),
      internetConnectionChecker: InternetConnectionChecker(),
    );
    
    _instance = ApiClient(
      networkInfo: netInfo,
      sharedPreferences: prefs,
    );
    
    return _instance!;
  }
  
  /// Réinitialise l'instance (utile pour les tests)
  static void reset() {
    _instance?.close();
    _instance = null;
  }
}