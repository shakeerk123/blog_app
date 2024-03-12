// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUpPreesedEvent>(authSignUpPreesedEvent);
  }

  FutureOr<void> authSignUpPreesedEvent(
      AuthSignUpPreesedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
        UserSignUpParam(event.email, event.name, event.passwprd));

    res.fold((failure) => emit(AuthFailure(failure.messgae)),
        (user) => emit(AuthSuccess(user)));
  }
}
