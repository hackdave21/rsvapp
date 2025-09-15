
import 'package:dartz/dartz.dart';
import 'package:rvsapp/core/errors/failures.dart';
import 'package:rvsapp/data/models/user_model.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, UserModel>> getUser(int id);
  Future<Either<Failure, List<UserModel>>> getUsers();
  Future<Either<Failure, UserModel>> updateUser(UserModel user);
  Future<Either<Failure, void>> deleteUser(int id);
}