import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepo authRepo;

  CurrentUser(this.authRepo);
  @override
  Future<Either<Failure, User>> call(NoParams param) async {
    return await authRepo.currentUser();
  }
}
