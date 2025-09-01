


import '../data/model/login_model.dart';

abstract class LoginState {}

class LoginUserInitial extends LoginState {}
class LoginUserLoading extends LoginState {}
class LoginUserLoaded extends LoginState {
  final LoginResponse loginData;
  LoginUserLoaded(this.loginData);
}
class LoginUserError extends LoginState {
  final String message;
  LoginUserError(this.message);
}