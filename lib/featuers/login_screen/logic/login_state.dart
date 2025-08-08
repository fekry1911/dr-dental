part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}
final class LoginSucc extends LoginState {}
final class LoginFail extends LoginState {
  String error;
  LoginFail({required this.error});
}
final class ToggleSecure extends LoginState{

  bool isSecure;
  ToggleSecure({required this.isSecure});
}

