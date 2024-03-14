// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
        (_, emit) => emit(AuthLoading())); // for catching all laading state
    on<AuthSignUpPreesedEvent>(authSignUpPreesedEvent);
    on<AuthLoginPreesedEvent>(authLoginPreesedEvent);
    on<IsUserLoggedIn>(isUserLoggedIn);
  }

  ////////////// Functions

  FutureOr<void> authSignUpPreesedEvent(
      AuthSignUpPreesedEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParam(event.email, event.name, event.password),
    );

    res.fold(
        (failure) => emit(
              AuthFailure(failure.messgae),
            ),
        (user) => _emitAuthSuccess(user, emit));
  }

////////LoginUser

  FutureOr<void> authLoginPreesedEvent(
      AuthLoginPreesedEvent event, Emitter<AuthState> emit) async {
    final response = await _userLogin(
      UserLoginParam(event.email, event.password),
    );
    response.fold(
        (failure) => emit(
              AuthFailure(failure.messgae),
            ),
        (user) => _emitAuthSuccess(user, emit));
  }

  FutureOr<void> isUserLoggedIn(
      IsUserLoggedIn event, Emitter<AuthState> emit) async {
    final result = await _currentUser(NoParams());
    result.fold(
        (failure) => emit(
              AuthFailure(failure.messgae),
            ), (user) {
      _emitAuthSuccess(user, emit);
    });
  }

//////  Persisting user using cubit app-wide User
 
  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
