
import 'package:dartz/dartz.dart';
import 'package:rvsapp/core/constants/storage_constants.dart';
import 'package:rvsapp/core/errors/failures.dart';
import 'package:rvsapp/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<Either<Failure, void>> cacheUser(UserModel user);
  Future<Either<Failure, UserModel?>> getCachedUser();
  Future<Either<Failure, void>> clearCachedUser();
  Future<Either<Failure, void>> cacheAuthToken(String token);
  Future<Either<Failure, String?>> getCachedAuthToken();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

 // Dans local_data_source.dart
@override
Future<Either<Failure, void>> cacheUser(UserModel user) async {
  try {
    await sharedPreferences.setString(
      StorageConstants.userData,
      user.toJsonString(),
    );
    return const Right(null);
  } catch (e) {
    return Left(CacheFailure('Erreur de cache: ${e.toString()}')); 
  }
}

@override
Future<Either<Failure, UserModel?>> getCachedUser() async {
  try {
    final userJson = sharedPreferences.getString(StorageConstants.userData);
    if (userJson == null) return const Right(null);
    
    return Right(UserModel.fromJsonString(userJson));
  } catch (e) {
    return Left(CacheFailure('Erreur de lecture cache: ${e.toString()}')); 
  }
}

@override
Future<Either<Failure, void>> clearCachedUser() async {
  try {
    await sharedPreferences.remove(StorageConstants.userData);
    await sharedPreferences.remove(StorageConstants.userId);
    await sharedPreferences.remove(StorageConstants.userEmail);
    return const Right(null);
  } catch (e) {
    return Left(CacheFailure('Erreur de nettoyage cache: ${e.toString()}')); 
  }
}

@override
Future<Either<Failure, void>> cacheAuthToken(String token) async {
  try {
    await sharedPreferences.setString(StorageConstants.authToken, token);
    return const Right(null);
  } catch (e) {
    return Left(CacheFailure('Erreur de cache token: ${e.toString()}')); 
  }
}

@override
Future<Either<Failure, String?>> getCachedAuthToken() async {
  try {
    final token = sharedPreferences.getString(StorageConstants.authToken);
    return Right(token);
  } catch (e) {
    return Left(CacheFailure('Erreur de lecture token: ${e.toString()}')); 
  }
}
}