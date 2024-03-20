// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';

class AuthReposImple implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionCheck connectionCheck;

  AuthReposImple(
    this.authRemoteDataSource,
    this.connectionCheck,
  );

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionCheck.isConnected)) {
        final session = authRemoteDataSource.userSession;

        if (session == null) {
          return left(Failure("User not logged in!"));
        }
        return right(UserModel(
            name: "", email: session.user.email ?? '', id: session.user.id));
      }
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("User not logged in"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

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

  ///// refracted function _getUser

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionCheck.isConnected)) {
        return left(Failure("No internet connection!"));
      }
      final user = await fn();

      return right(user);
    } on supa.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
