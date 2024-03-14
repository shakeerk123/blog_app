import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UseCase<User, UserLoginParam> {
  final AuthRepo authRepo;

  UserSignIn(this.authRepo);
  @override
  Future<Either<Failure, User>> call(UserLoginParam param) async {
    return await authRepo.loginInWithEmailandPassword(
        email: param.email, password: param.password);
  }
}

class UserLoginParam {
  final String email;
  final String password;

  UserLoginParam(
    this.email,
    this.password,
  );
}
