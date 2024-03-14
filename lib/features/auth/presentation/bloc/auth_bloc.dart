// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userLogin;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUpPreesedEvent>(authSignUpPreesedEvent);
    on<AuthLoginPreesedEvent>(authLoginPreesedEvent);
  }

  ////////////// Functions

  FutureOr<void> authSignUpPreesedEvent(
      AuthSignUpPreesedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
        UserSignUpParam(event.email, event.name, event.password));

    res.fold((failure) => emit(AuthFailure(failure.messgae)),
        (user) => emit(AuthSuccess(user)));
  }

  FutureOr<void> authLoginPreesedEvent(
      AuthLoginPreesedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response =
        await _userLogin(UserLoginParam(event.email, event.password));
    response.fold((failure) => emit(AuthFailure(failure.messgae)),
        (user) => emit(AuthSuccess(user)));
  }
}
