// Dans votre provider/service qui gère l'API
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rvsapp/core/constants/storage_constants.dart';
import 'package:rvsapp/core/network/interceptors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  late final Dio _dio;
  final BuildContext context;

  ApiService(this.context) {
    _dio = Dio(BaseOptions(
      baseUrl: 'lien de api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _setupInterceptors();
  }

  Future<void> _setupInterceptors() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    
    _dio.interceptors.add(AuthInterceptor(
      sharedPreferences: sharedPreferences,
      onUnauthorized: _handleTokenExpiration,
    ));
    
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
  }

  void _handleTokenExpiration() {
    // nettoyer les données utilisateur
    _clearUserData();
    
    // rediriger vers le login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
      
      //afficher un message à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Session expirée, veuillez vous reconnecter'),
          backgroundColor: Colors.orange,
        ),
      );
    });
  }

  Future<void> _clearUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(StorageConstants.authToken);
    await sharedPreferences.remove(StorageConstants.userId);
    await sharedPreferences.remove(StorageConstants.userEmail);
    // nettoyer d'autres données sensibles si nécessaire
  }

  // Vos méthodes API...
  // Future<Response> getProperties() async {
  //   return await _dio.get('/properties');
  // }
}