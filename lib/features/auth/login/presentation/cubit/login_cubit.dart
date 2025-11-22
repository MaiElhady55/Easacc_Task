import 'package:bloc/bloc.dart';
import 'package:easacc_task/features/auth/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repository;
  LoginCubit(this.repository) : super(LoginInitial());

  

  Future<void> loginWithGoogle() async {
    emit(GoogleLoginLoading());
    final result = await repository.loginByGoogle();

    result.fold(
      (failure) => emit(GoogleLoginFailure(failure.message)),
      (message) => emit(GoogleLoginSuccess(message)),
    );
  }

  Future<void> loginWithFacebook() async {
    emit(FacebookLoginLoading());
    final result = await repository.loginByFacebook();

    result.fold(
      (failure) => emit(FacebookLoginFailure(failure.message)),
      (message) => emit(FacebookLoginSuccess(message)),
    );
  }
}
