part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpPreesedEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUpPreesedEvent(this.email, this.password, this.name);
}

final class AuthLoginPreesedEvent extends AuthEvent {
  final String email;
  final String password;
  

  AuthLoginPreesedEvent(this.email, this.password,);
}

final class  IsUserLoggedIn  extends AuthEvent {}