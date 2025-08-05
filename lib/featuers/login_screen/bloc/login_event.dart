part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginInitialEvent extends LoginEvent {}

class TabSwitchEvent extends LoginEvent {
  final bool isLoginTab;

  const TabSwitchEvent({required this.isLoginTab});

  @override
  List<Object?> get props => [isLoginTab];
}

class EmailChangedEvent extends LoginEvent {
  final String email;

  const EmailChangedEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordChangedEvent extends LoginEvent {
  final String password;

  const PasswordChangedEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

class TogglePasswordVisibilityEvent extends LoginEvent {}

class LoginButtonPressedEvent extends LoginEvent {}

class ForgotPasswordEvent extends LoginEvent {}

class GoogleLoginEvent extends LoginEvent {}

class FacebookLoginEvent extends LoginEvent {}
