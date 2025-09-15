
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:rvsapp/core/constants/storage_constants.dart';
import 'package:rvsapp/core/errors/failures.dart';
import 'package:rvsapp/core/network/interceptors.dart';
import 'package:rvsapp/data/datasources/remote_data_source.dart';
import 'package:rvsapp/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService implements RemoteDataSource {
  late final Dio _dio;
  final SharedPreferences sharedPreferences;
  final Function()? onTokenExpired;

  ApiService({
    required this.sharedPreferences,
    this.onTokenExpired,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://votre-api.com/api', 
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _setupInterceptors();
  }

  Future<void> _setupInterceptors() async {
    _dio.interceptors.add(AuthInterceptor(
      sharedPreferences: sharedPreferences,
      onUnauthorized: _handleTokenExpiration,
    ));
    
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
  }

  void _handleTokenExpiration() {
    _clearUserData();
    onTokenExpired?.call();
  }

  Future<void> _clearUserData() async {
    await sharedPreferences.remove(StorageConstants.authToken);
    await sharedPreferences.remove(StorageConstants.userId);
    await sharedPreferences.remove(StorageConstants.userEmail);
  }

  // Implementation des méthodes de l'interface RemoteDataSource
@override
Future<Either<Failure, UserModel>> getUser(int id) async {
  try {
    final response = await _dio.get('/users/$id');
    return Right(UserModel.fromJson(response.data));
  } on DioException catch (e) {
    return Left(ServerFailure.fromDioException(e)); 
  } catch (e) {
    return Left(ServerFailure('Erreur inattendue: ${e.toString()}'));
  }
}

@override
Future<Either<Failure, List<UserModel>>> getUsers() async {
  try {
    final response = await _dio.get('/users');
    final users = (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
    return Right(users);
  } on DioException catch (e) {
    return Left(ServerFailure.fromDioException(e)); 
  } catch (e) {
    return Left(ServerFailure('Erreur inattendue: ${e.toString()}'));
  }
}

@override
Future<Either<Failure, UserModel>> updateUser(UserModel user) async {
  try {
    final response = await _dio.put(
      '/users/${user.id}',
      data: user.toJson(),
    );
    return Right(UserModel.fromJson(response.data));
  } on DioException catch (e) {
    return Left(ServerFailure.fromDioException(e)); 
  } catch (e) {
    return Left(ServerFailure('Erreur inattendue: ${e.toString()}'));
  }
}

@override
Future<Either<Failure, void>> deleteUser(int id) async {
  try {
    await _dio.delete('/users/$id');
    return const Right(null);
  } on DioException catch (e) {
    return Left(ServerFailure.fromDioException(e)); 
  } catch (e) {
    return Left(ServerFailure('Erreur inattendue: ${e.toString()}'));
  }
}
}