import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

class AuthReposImple implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthReposImple(this.authRemoteDataSource);
  @override
  Future<Either<Failure, User>> loginInWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(() async => await authRemoteDataSource
        .loginInWithEmailPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signInWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(() async => await authRemoteDataSource
        .signUpWithEmailPassword(name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();

      return right(user);
    } on supa.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}