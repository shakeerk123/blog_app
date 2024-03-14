import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, User>> signInWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginInWithEmailandPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
