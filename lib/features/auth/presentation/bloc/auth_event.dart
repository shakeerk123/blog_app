part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpPreesedEvent extends AuthEvent {
  final String email;
  final String passwprd;
  final String name;

  AuthSignUpPreesedEvent(this.email, this.passwprd, this.name);
}
