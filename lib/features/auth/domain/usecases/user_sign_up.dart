import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';


class UserSignUp implements UseCase<User, UserSignUpParam> {
  final AuthRepo authRepo;

  UserSignUp(this.authRepo);
  @override
  Future<Either<Failure, User>> call(UserSignUpParam param) async {
    return await authRepo.signInWithEmailandPassword(
      name: param.name,
      email: param.email,
      password: param.password,
    );
  }
}

class UserSignUpParam {
  final String email;
  final String name;
  final String password;

  UserSignUpParam(
    this.email,
    this.name,
    this.password,
  );
}
