part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

//google states
class GoogleLoginLoading extends LoginState {}

class GoogleLoginSuccess extends LoginState {
  final String message;
  GoogleLoginSuccess(this.message);
}

class GoogleLoginFailure extends LoginState {
  final String error;
  GoogleLoginFailure(this.error);
}

//facebook states
class FacebookLoginLoading extends LoginState {}

class FacebookLoginSuccess extends LoginState {
  final String message;
  FacebookLoginSuccess(this.message);
}

class FacebookLoginFailure extends LoginState {
  final String error;
  FacebookLoginFailure(this.error);
}
